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

resource "azurerm_resource_group" "mtc-rg" {
  name     = "app-dev-rg"
  location = "East Us"
  tags = {
    environment = "dev"
  }
}


resource "azurerm_virtual_network" "mtc-network" {
  name                = "mtc-network"
  resource_group_name = azurerm_resource_group.mtc-rg.name
  location            = azurerm_resource_group.mtc-rg.location
  tags = {
    "environment" = "dev"
  }
  address_space = ["10.123.0.0/16"]
}

resource "azurerm_subnet" "mtc-subnet" {
  name                 = "mtc-subnet"
  resource_group_name  = azurerm_resource_group.mtc-rg.name
  virtual_network_name = azurerm_virtual_network.mtc-network.name
  address_prefixes     = ["10.123.1.0/27"]
}

resource "azurerm_network_security_group" "mtc-nsg" {
  name                = "mtc-network-security-group"
  resource_group_name = azurerm_resource_group.mtc-rg.name
  location            = azurerm_resource_group.mtc-rg.location
  tags = {
    "environment" = "dev"
  }
}


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


resource "azurerm_subnet_network_security_group_association" "mtc-nsg-association" {
  subnet_id                 = azurerm_subnet.mtc-subnet.id
  network_security_group_id = azurerm_network_security_group.mtc-nsg.id
}
