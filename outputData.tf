data "azurerm_public_ip" "monitoring-ip-data"{
    name = azurerm_public_ip.monitoring-public-ip.name
    resource_group_name = azurerm_resource_group.monitoring-resource-group.name
}

output "VM-public-IPs" {
    value = " ${azurerm_linux_virtual_machine.monitoring-vm-001.name}: ${data.azurerm_public_ip.monitoring-ip-data.ip_address}"
}