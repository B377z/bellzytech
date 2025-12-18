terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
}

module "locations" {
  source                = "../../../shared_modules/locations"
  primary_location_only = var.primary_location_only
}
