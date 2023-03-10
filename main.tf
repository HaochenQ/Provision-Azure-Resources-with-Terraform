# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      //version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "The resource group of pre-configured storage account"
    storage_account_name = "The pre-configured storage account name"
    container_name       = "The name of the container that stores the state file"
    key                  = "The key for the terraform state file"
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

module "app_service" {
  source = "./modules/app_service"

  prefix         = var.prefix
  location       = var.location
  resource_group = azurerm_resource_group.rg.name
}

module "vnet" {
  source = "Azure/vnet/azurerm"
  # insert the 3 required variables here
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = "${var.prefix}-vnet"
  use_for_each        = true

  vnet_location   = var.location
  subnet_names    = ["subnet1", "subnet2", "subnet3"]
  subnet_prefixes = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

}

resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = module.app_service.id
  subnet_id      = module.vnet.vnet_subnets[0]
}
