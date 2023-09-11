

resource "azurerm_resource_group" "shared" {
  name     = "demo-layer-200"
  location = "westeurope"
}


resource "azurerm_resource_group" "c1" {
  name     = "demo-customer-1-layer-400"
  location = "westeurope"
}


resource "azurerm_resource_group" "c2" {
  name     = "demo-customer-2-layer-400"
  location = "westeurope"
}

