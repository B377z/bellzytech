terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
}

module "subscriptions" {
  source = "../../../shared_modules/subscriptions"

  # If you use provider aliases in this env, pass them:
  # providers = { azurerm = azurerm.tbb }  # or azurerm.tfd_prd, etc.
}

