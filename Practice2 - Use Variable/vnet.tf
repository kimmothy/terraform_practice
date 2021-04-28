resource "azurerm_virtual_network" "vnet_chan_sample" {
  name                = "vnet-chan-sample"
  address_space       = ["172.16.0.0/16"]
  location            = azurerm_resource_group.rg_chan_sample.location["long"]
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
}

resource "azurerm_subnet" "web_subnet" {
  count = var.vmcount
  name                 = "web_subnet"
  resource_group_name  = azurerm_resource_group.rg_chan_sample.name
  virtual_network_name = azurerm_virtual_network.vnet_chan_sample.name
  address_prefixes     = ["172.16.${count.index + 1}.0/24"]
}

resource "azurerm_subnet" "AGW_subnet" {
  name                 = "AGW_subnet"
  resource_group_name  = azurerm_resource_group.rg_chan_sample.name
  virtual_network_name = azurerm_virtual_network.vnet_chan_sample.name
  address_prefixes     = ["172.16.2.0/24"]
}
