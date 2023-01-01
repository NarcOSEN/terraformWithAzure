
#defining a subnet of this virtual network
resource "azurerm_subnet" "mtc-subnet" {
  name                 = "mtc-subnet"
  resource_group_name  = azurerm_resource_group.mtc-rg.name
  virtual_network_name = azurerm_virtual_network.mtc-network.name
  address_prefixes     = ["10.123.1.0/27"]
}