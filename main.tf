#defining the required providers
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}


#defining the resource group
resource "azurerm_resource_group" "mtc-rg" {
  name     = "app-dev-rg"
  location = "East Us"
  tags = {
    environment = "dev"
  }
}

#defining the virtual network
resource "azurerm_virtual_network" "mtc-network" {
  name                = "mtc-network"
  resource_group_name = azurerm_resource_group.mtc-rg.name
  location            = azurerm_resource_group.mtc-rg.location
  tags = {
    "environment" = "dev"
  }
  address_space = ["10.123.0.0/16"]
}


#defining a subnet of this virtual network
resource "azurerm_subnet" "mtc-subnet" {
  name                 = "mtc-subnet"
  resource_group_name  = azurerm_resource_group.mtc-rg.name
  virtual_network_name = azurerm_virtual_network.mtc-network.name
  address_prefixes     = ["10.123.1.0/27"]
}


#defining a network security group attached to this resource group
resource "azurerm_network_security_group" "mtc-nsg" {
  name                = "mtc-network-security-group"
  resource_group_name = azurerm_resource_group.mtc-rg.name
  location            = azurerm_resource_group.mtc-rg.location
  tags = {
    "environment" = "dev"
  }
}

#defining a network security rule
resource "azurerm_network_security_rule" "mtc-network-security-rule" {
  name                        = "mtc-nsr"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.mtc-rg.name
  network_security_group_name = azurerm_network_security_group.mtc-nsg.name
}


#defining a network security group association 
#in other words, linking the network security group and the subnet
resource "azurerm_subnet_network_security_group_association" "mtc-nsg-association" {
  subnet_id                 = azurerm_subnet.mtc-subnet.id
  network_security_group_id = azurerm_network_security_group.mtc-nsg.id
}


#defining a public IP.
resource "azurerm_public_ip" "mtc-public-ip" {
  name                = "mtc-public-ip"
  resource_group_name = azurerm_resource_group.mtc-rg.name
  location            = azurerm_resource_group.mtc-rg.location
  allocation_method   = "Static"

  tags = {
    environment = "dev"
  }
}

#defining a network interface (I think this is the equivalent of a physical network interface card)
resource "azurerm_network_interface" "mtc-net-interf" {
  name                = "mtc-nic"
  resource_group_name = azurerm_resource_group.mtc-rg.name
  location            = azurerm_resource_group.mtc-rg.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mtc-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mtc-public-ip.id

  }
  tags = {
    environment = "dev"
  }
}



#Creating the actual VM and attaching the required stuff to it
resource "azurerm_linux_virtual_machine" "mtc-vm" {
  name                  = "VM01"
  resource_group_name   = azurerm_resource_group.mtc-rg.name
  location              = azurerm_resource_group.mtc-rg.location
  size                  = "Standard_F2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.mtc-net-interf.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/home/narcosen/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
