resource "azurerm_public_ip" "pip_chan_sample" {
  name                = "pip-chan-sample-${var.location["short"]}"
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
  location            = azurerm_resource_group.rg_chan_sample.location
  allocation_method   = "Dynamic"

}

locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet_chan_sample.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnet_chan_sample.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet_chan_sample.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet_chan_sample.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet_chan_sample.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet_chan_sample.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.vnet_chan_sample.name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = "example-appgateway"
  resource_group_name = azurerm_resource_group.rg_chan_sample.name
  location            = var.location["long"]

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.AGW_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip_chan_sample.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}