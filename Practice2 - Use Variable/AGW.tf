resource "azurerm_public_ip" "pip_chan_sample" {
  count = var.vmcount
  name                = "pip-chan-sample-${var.location["short"]}-${count.index}"
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
  location            = azurerm_resource_group.rg_chan_sample.location["long"]
  allocation_method   = "Static"

}