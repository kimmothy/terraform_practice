resource "azurerm_virtual_network" "vnet_chan_sample" {
  name                = "vnet-chan-sample"
  address_space       = [var.cidr_block]
  location            = azurerm_resource_group.rg_chan_sample.location
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
}


resource "azurerm_subnet" "web_subnet" {
  count                = var.subnet_count
  name                 = "web_subnet_${count.index}"
  resource_group_name  = azurerm_resource_group.rg_chan_sample.name
  virtual_network_name = azurerm_virtual_network.vnet_chan_sample.name
  address_prefixes     = [cidrsubnet(var.cidr_block, 4, count.index)]
}
