#defining a network security group attached to this resource group
resource "azurerm_network_security_group" "monitoring-nsg" {
  name                = "monitoring-network-security-group"
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
  location            = azurerm_resource_group.monitoring-resource-group.location
  tags = {
    "environment" = "monitoring"
  }
}

#defining a network security rule
resource "azurerm_network_security_rule" "monitoring-network-security-rule-01" {
  name                        = "monitoring-nsr-001"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.monitoring-resource-group.name
  network_security_group_name = azurerm_network_security_group.monitoring-nsg.name
}


#defining a network security group association 
#in other words, linking the network security group and the subnet
resource "azurerm_subnet_network_security_group_association" "monitoring-nsg-association" {
  subnet_id                 = azurerm_subnet.monitoring-vm-subnet.id
  network_security_group_id = azurerm_network_security_group.monitoring-nsg.id
}

