#defining a network security group attached to this resource group
resource "azurerm_network_security_group" "mtc-nsg" {
  name                = "mtc-network-security-group"
  resource_group_name = azurerm_resource_group.mtc-rg.name
  location            = azurerm_resource_group.mtc-rg.location
  tags = {
    "environment" = "dev"
  }
}

#defining a network security rule
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


#defining a network security group association 
#in other words, linking the network security group and the subnet
resource "azurerm_subnet_network_security_group_association" "mtc-nsg-association" {
  subnet_id                 = azurerm_subnet.mtc-subnet.id
  network_security_group_id = azurerm_network_security_group.mtc-nsg.id
}

