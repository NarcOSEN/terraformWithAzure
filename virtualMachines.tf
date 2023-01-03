
#defining a network interface (I think this is the equivalent of a physical network interface card)
resource "azurerm_network_interface" "monitoring-vm-001-network-interface-card" {
  name                = "vm-001-network-interface-card"
  resource_group_name = azurerm_resource_group.monitoring-resource-group.name
  location            = azurerm_resource_group.monitoring-resource-group.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.monitoring-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.monitoring-public-ip.id

  }
  tags = {
    environment = "monitoring"
  }
}


#Creating the actual VM and attaching the required stuff to it
resource "azurerm_linux_virtual_machine" "monitoring-vm-001" {
  name                  = "monitoring-VM01"
  resource_group_name   = azurerm_resource_group.monitoring-resource-group.name
  location              = azurerm_resource_group.monitoring-resource-group.location
  size                  = "Standard_D2as_v4"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.monitoring-vm-001-network-interface-card.id]
  priority              = "Spot"
  eviction_policy       = "Deallocate"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/home/narcosen/.ssh/id_rsa.pub")
  }
  custom_data = filebase64("customData.tpl")
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

