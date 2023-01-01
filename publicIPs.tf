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