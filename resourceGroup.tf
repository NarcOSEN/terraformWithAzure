
#defining the resource group
resource "azurerm_resource_group" "mtc-rg" {
  name     = "app-dev-rg"
  location = "East Us"
  tags = {
    environment = "dev"
  }
}