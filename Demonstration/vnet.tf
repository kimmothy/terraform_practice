resource "azurerm_virtual_network" "vnet_chan_sample" {
  name                = "vnet-chan-sample"
  address_space       = ["172.16.0.0/16"]
  location            = azurerm_resource_group.rg_chan_sample.location
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
}

resource "azurerm_subnet" "external" {
  name                 = "external"
  resource_group_name  = azurerm_resource_group.rg_chan_sample.name
  virtual_network_name = azurerm_virtual_network.vnet_chan_sample.name
  address_prefixes     = ["172.16.0.0/24"]
}