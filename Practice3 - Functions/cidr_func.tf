variable "cidr" {
    type = string
    default = "172.16.0.0/16"
}

variable "subnet_count" {
    type = number
    default = 4
}
resource "azurerm_virtual_network" "vnet_chan_sample" {
  name                = "vnet-chan-sample"
  address_space       = [var.cidr]
  location            = azurerm_resource_group.rg_chan_sample.location
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
}

resource "azurerm_subnet" "AGW_subnet" {
  name                 = "AGW_subnet"
  resource_group_name  = azurerm_resource_group.rg_chan_sample.name
  virtual_network_name = azurerm_virtual_network.vnet_chan_sample.name
  address_prefixes     = [cidrsubnet(var.cidr, 4, 0)]
}


resource "azurerm_subnet" "web_subnet" {
  count = var.subnet_count
  name                 = "web_subnet_${count.index}"
  resource_group_name  = azurerm_resource_group.rg_chan_sample.name
  virtual_network_name = azurerm_virtual_network.vnet_chan_sample.name
  address_prefixes     = [cidrsubnet(var.cidr, 4, count.index + 1)]
}

# output cidrhost_test {
#     value = cidrhost("10.12.128.0/20", 0)
# }