#defining the virtual network
resource "azurerm_virtual_network" "monitoring-virtual-network" {
  name                = "monitoring-virtual-network"
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
  location            = azurerm_resource_group.monitoring-resource-group.location
  tags = {
    "environment" = "monitoring"
  }
  address_space = ["10.123.0.0/16"]
}