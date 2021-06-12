resource "azurerm_public_ip" "pip_chan_sample" {
  name                = "pip-chan-sample"
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
  location            = azurerm_resource_group.rg_chan_sample.location
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "nic_chan_sample" {
  name                = "nic-chan-sample"
  location            = azurerm_resource_group.rg_chan_sample.location
  resource_group_name = azurerm_resource_group.rg_chan_sample.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.external.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_chan_sample.id
  }
}

resource "azurerm_linux_virtual_machine" "vm_chan_sample" {
  name                = "vm-chan-sample"
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
  location            = azurerm_resource_group.rg_chan_sample.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  admin_password = "{your_password}"
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