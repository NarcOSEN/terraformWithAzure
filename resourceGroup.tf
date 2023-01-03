
#defining the resource group
resource "azurerm_resource_group" "monitoring-resource-group" {
  name     = "monitoring-resource-group"
  location = "East Us"
  tags = {
    environment = "monitoring"
  }
}