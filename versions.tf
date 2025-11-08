terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.43.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.0"
    }
  }
}

/* Remove the default providers from here to avoid duplicates:
provider "azurerm" { features { key_vault { purge_soft_delete_on_destroy = false } } }
provider "azuread" {}
*/
