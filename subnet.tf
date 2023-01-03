
#defining a subnet of this virtual network
resource "azurerm_subnet" "monitoring-vm-subnet" {
  name                 = "monitoring-vm-subnet"
  resource_group_name  = azurerm_resource_group.monitoring-resource-group.name
  virtual_network_name = azurerm_virtual_network.monitoring-virtual-network.name
  address_prefixes     = ["10.123.1.0/27"]
}
