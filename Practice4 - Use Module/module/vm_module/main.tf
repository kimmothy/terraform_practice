provider "azurerm" {
    features {}
}

resource "azurerm_network_interface" "nic_chan_sample" {
  name                = "nic-chan-sample-${var.location["short"]}"
  location            = var.location["long"]
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "vm_chan_sample" {
  name                = "vm-chan-sample-${var.location["short"]}"
  resource_group_name = var.rgname
  location            = var.location["long"]
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.nic_chan_sample.id,
  ]
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/sshkey_chan.pub")
  }

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