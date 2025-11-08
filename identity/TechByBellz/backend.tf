terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-tbb-rg"
    storage_account_name = "terraformtbbstate7565"
    container_name       = "tfstate"
    key                  = "identity/TechByBellz/terraform.tfstate"
  }
}
