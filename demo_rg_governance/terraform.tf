terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.35.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "=1.6.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id # demo-governance
}
