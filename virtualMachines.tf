
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
  size                  = "Standard_D2as_v4"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.mtc-net-interf.id]
  priority              = "Spot"
  eviction_policy       = "Deallocate"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/home/narcosen/id_rsa.pub")
  }
  custom_data = filebase64("customData.tpl")
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

