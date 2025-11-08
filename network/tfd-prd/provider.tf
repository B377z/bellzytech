terraform {
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

provider "azurerm" {
  alias = "techbybellz"
  features {}

  tenant_id       = "8ff68f27-15e1-495a-9035-c162afc26e56"
  subscription_id = "8493dc0b-b480-40dd-bef5-c47dce3a9348"

  use_oidc      = true
  client_id     = "d425b0db-beaa-4703-af83-1614920f114e"
  client_secret = var.techbybellz_sp_secret
}

provider "azurerm" {
  alias = "tfd_npd"
  features {}

  tenant_id       = "fd34fbf2-afa8-4adc-bef6-9f296fd46e66"
  subscription_id = "1eaee368-1764-4383-9c12-9a596a909bec"

  use_oidc      = true # ← add these two lines so it actually authenticates
  client_id     = "57c85b98-e28c-46a2-a1d6-83ffc6bd35bc"
  client_secret = var.tfd_npd_sp_secret
}

provider "azurerm" {
  alias = "tfd_prd"
  features {}

  tenant_id       = "fd34fbf2-afa8-4adc-bef6-9f296fd46e66"
  subscription_id = "9d36219a-89a8-448f-adcf-9fa9fa4cd328"

  use_oidc      = true # ← add these two lines so it actually authenticates
  client_id     = "8259dc3c-410b-4c57-a71f-9bcf9723706b"
  client_secret = var.tfd_prd_sp_secret
}


