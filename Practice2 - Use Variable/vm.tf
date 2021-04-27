resource "azurerm_network_interface" "nic_chan_sample" {
  count = var.vmcount
  name                = "nic-chan-sample-${var.location["short"]}-${count.index}"
  location            = azurerm_resource_group.rg_chan_sample.location["long"]
  resource_group_name = azurerm_resource_group.rg_chan_sample.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.external[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm_chan_sample" {
  count = var.vmcount
  name                = "vm-chan-sample-${var.location["short"]}-${count.index}"
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
  location            = azurerm_resource_group.rg_chan_sample.location["long"]
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  admin_password = var.password
  network_interface_ids = [
    azurerm_network_interface.nic_chan_sample.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}