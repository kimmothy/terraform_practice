resource "azurerm_network_security_group" "sg_chan_sample" {
  name                = "sg-chan-sample"
  location            = var.location["long"]
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow_ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.localips
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_chan_sample.name
  network_security_group_name = azurerm_network_security_group.sg_chan_sample.name
}

resource "azurerm_subnet_network_security_group_association" "sgasso_chan_sample" {
  subnet_id                 = azurerm_subnet.external.id
  network_security_group_id = azurerm_network_security_group.sg_chan_sample.id
}