resource "azurerm_virtual_network" "vnet_chan_sample" {
  name                = "vnet-chan-sample"
  address_space       = ["172.16.0.0/16"]
  location            = azurerm_resource_group.rg_chan_sample.location["long"]
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
}

resource "azurerm_subnet" "external" {
  count = var.vmcount
  name                 = "external"
  resource_group_name  = azurerm_resource_group.rg_chan_sample.name
  virtual_network_name = azurerm_virtual_network.vnet_chan_sample.name
  address_prefixes     = ["172.16.${count.index}.0/24"]
}
