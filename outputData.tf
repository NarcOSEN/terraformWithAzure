data "azurerm_public_ip" "monitoring-ip-data" {
  name                = azurerm_public_ip.monitoring-public-ip.name
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
}

output "VM-public-IPs" {
  value = " ${azurerm_linux_virtual_machine.monitoring-vm-001.name}: ${data.azurerm_public_ip.monitoring-ip-data.ip_address}"
}


data "azurerm_network_interface" "vm001-private-ip" {
  name                = azurerm_network_interface.monitoring-vm-001-network-interface-card.name
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
}


data "azurerm_network_interface" "vm002-private-ip" {
  name                = azurerm_network_interface.monitoring-vm-002-network-interface-card.name
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
}


data "azurerm_network_interface" "vm003-private-ip" {
  name                = azurerm_network_interface.monitoring-vm-003-network-interface-card.name
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
}


output "vm001-private-ip-address" {
  value = "Private IP:  ${azurerm_linux_virtual_machine.monitoring-vm-001.name}: ${data.azurerm_network_interface.vm001-private-ip.private_ip_address}"
}

output "vm002-private-ip-address" {
  value = "Private IP: ${azurerm_linux_virtual_machine.monitoring-vm-002.name}: ${data.azurerm_network_interface.vm002-private-ip.private_ip_address}"
}

output "vm003-private-ip-address" {
  value = "Private IP: ${azurerm_linux_virtual_machine.monitoring-vm-003.name}: ${data.azurerm_network_interface.vm003-private-ip.private_ip_address}"
}
