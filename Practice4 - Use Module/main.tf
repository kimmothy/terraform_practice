terraform{
    required_version = "v0.14.2"
}

provider "azurerm" {
    features {}
}

module "vnet_module" {
    source = "./module/vnet_module"
    cidr_block = "10.0.0.0/16"
    subnet_count = "8"
}

module "vm_module" {
    source = "./module/vm_module"
    subnet_id = module.vnet_module.subnet_id
    rgname = "rg-chan-sample"
}


output "output_from_module" {
    value = module.vnet_module.subnet_id
}
