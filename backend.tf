# terraform {
#   backend "azurerm" {
#     resource_group_name  = azurerm_resource_group.res-01.name
#     storage_account_name = azurerm_storage_account.res-01.name                  
#     container_name       = azurerm_storage_container.res-01.name                      
#     key                  = "initial.tfstate"        
#   }
# }