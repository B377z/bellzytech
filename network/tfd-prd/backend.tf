terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-prd-cacn-rg"
    storage_account_name = "terraformprdstate9402"
    container_name       = "tfstate"
    key                  = "network/tfd-prd/terraform.tfstate"
  }
}
