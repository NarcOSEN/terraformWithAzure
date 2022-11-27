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

