terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "jwetfstatesa"                 
    container_name       = "tfstate"                    
    key                  = "initial.tfstate"        
  }
}