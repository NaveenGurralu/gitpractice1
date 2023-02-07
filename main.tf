terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate848415809"
    container_name       = "tfstate"
    key                  = "Terradependson.tfstate"
  }

}

provider "azurerm" {
  features {}

  subscription_id = "6d5dd6ed-ca43-48d9-8ad9-394f10251713"
  tenant_id       = "a2301a78-8697-4d47-a89b-0ac34f796b42"
  client_id       = "3c05df66-5c45-4d4a-baa1-2beaa0658335"
  client_secret   = "dFcWOFCB1aIIXrSuH4rhRkptzlXOqB6.5t"
}


resource "azurerm_resource_group" "myrg" {

  name     = "rg-Dependson"
  location = "EastUs"

}


resource "azurerm_virtual_network" "vnet1" {

  depends_on = [
    azurerm_resource_group.myrg
  ]
  name                = "dependsnetwork"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  address_space       = ["10.50.0.0/16"]
}

resource "azurerm_subnet" "sub1" {

  depends_on = [
    azurerm_virtual_network.vnet1
  ]
  name                 = "newsubnet"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.50.10.0/24"]
}