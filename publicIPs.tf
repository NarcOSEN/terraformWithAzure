#defining a public IP.
resource "azurerm_public_ip" "monitoring-public-ip" {
  name                = "monitoring-public-ip"
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
  location            = azurerm_resource_group.monitoring-resource-group.location
  allocation_method   = "Static"

  tags = {
    environment = "monitoring"
  }
}