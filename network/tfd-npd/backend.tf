terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-npd-cacn-rg"
    storage_account_name = "terraformnpdstate5984"
    container_name       = "tfstate"
    key                  = "network/tfd-npd/terraform.tfstate"
  }
}
