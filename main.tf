resource "azurerm_resource_group" "res-01" {
  name     = "jwereceipttracker"
  location = var.location
}

resource "azurerm_storage_account" "res-01" {
  name                     = "receipttrackersa"
  resource_group_name      = azurerm_resource_group.res-01.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "res-01" {
  name                  = "receipts"
  storage_account_name  = azurerm_storage_account.res-01.name
  container_access_type = "private"
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

resource "azurerm_service_plan" "res-01" {
  name                = "receipttrackerasp"
  resource_group_name = azurerm_resource_group.res-01.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "res-01" {
  name                = "receipttrackerapp"
  depends_on = [
    azurerm_service_plan.res-01
  ]

  resource_group_name = azurerm_resource_group.res-01.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.res-01.id

  site_config {
    always_on = false
  }
}

resource "azurerm_linux_function_app" "res-01" {
  name                = "receipt analysis"
  resource_group_name = azurerm_resource_group.res-01.name
  location            = azurerm_resource_group.res-01.location

  storage_account_name       = azurerm_storage_account.res-01.name
  storage_account_access_key = azurerm_storage_account.res-01.primary_access_key
  service_plan_id            = azurerm_service_plan.res-01.id

  site_config {}
}

resource "azurerm_cognitive_account" "res-01" {
  name                = "rtcognitive"
  location            = azurerm_resource_group.res-01.location
  resource_group_name = azurerm_resource_group.res-01.name
  kind                = "ComputerVision"

  sku_name = "F0"
}
