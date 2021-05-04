terraform{
    required_version = "v0.14.2"
}

provider "azurerm" {
    features {}
}

module "sample_module" {
    source = "./module/sample_rg"
    cidr_block = "10.0.0.0/16"
    subnet_count = "8"
}