data "azurerm_public_ip" "mtc-ip-data"{
    name = azurerm_public_ip.mtc-public-ip.name
    resource_group_name = azurerm_resource_group.mtc-rg.name
}

output "VM-public-IPs" {
    value = " ${azurerm_linux_virtual_machine.mtc-vm.name}:${data.azurerm_public_ip.mtc-public-ip.ip_address}"
}