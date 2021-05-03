terraform{
    required_version = "v0.14.2"
}

provider "azurerm" {
    features {}
}

module "sample_module" {
    source = "./module/sample_rg"
    
}