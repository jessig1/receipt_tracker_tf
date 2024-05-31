resource "azurerm_resource_group" "res-01" {
  name     = "jwereceipttracker"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  depends_on = [
    azurerm_resource_group.res-01
  ]

  name                = "receipttrackerregister"
  resource_group_name = azurerm_resource_group.res-01.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
}

# resource "azurerm_service_plan" "res-01" {
#   name                = "example"
#   resource_group_name = azurerm_resource_group.res-01.name
#   location            = var.location
#   os_type             = "Linux"
#   sku_name            = "P1v2"
# }

# resource "azurerm_linux_web_app" "res-01" {
#   name                = "example"
#   resource_group_name = azurerm_resource_group.res-01.name
#   location            = var.location
#   service_plan_id     = azurerm_service_plan.res-01.id

#   site_config {}
# }