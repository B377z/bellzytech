module "subscriptions" {
  source = "../modules/subscriptions"
  providers = {
    azurerm = azurerm.techbybellz
  }
}

data "terraform_remote_state" "identity_TechByBellz_state" {
  backend = "azurerm"

  config = {
    use_oidc             = true
    tenant_id            = "8ff68f27-15e1-495a-9035-c162afc26e56"
    subscription_id      = "8493dc0b-b480-40dd-bef5-c47dce3a9348"
    resource_group_name  = "terraform-state-tbb-rg"
    storage_account_name = "terraformtbbstate7565"
    container_name       = "tfstate"
    key                  = "identity/TechByBellz/terraform.tfstate"
  }
}

data "terraform_remote_state" "identity_tfd_npd_state" {
  backend = "azurerm"

  config = {
    use_oidc             = true
    tenant_id            = "fd34fbf2-afa8-4adc-bef6-9f296fd46e66"
    resource_group_name  = "terraform-state-npd-cacn-rg"
    subscription_id      = "1eaee368-1764-4383-9c12-9a596a909bec"
    storage_account_name = "terraformnpdstate5984"
    container_name       = "tfstate"
    key                  = "identity/tfd-npd/terraform.tfstate"
  }
}

data "terraform_remote_state" "identity_tfd_prd_state" {
  backend = "azurerm"

  config = {
    use_oidc             = true
    tenant_id            = "fd34fbf2-afa8-4adc-bef6-9f296fd46e66"
    resource_group_name  = "terraform-state-prd-cacn-rg"
    subscription_id      = "9d36219a-89a8-448f-adcf-9fa9fa4cd328"
    storage_account_name = "terraformprdstate9402"
    container_name       = "tfstate"
    key                  = "identity/tfd-prd/terraform.tfstate"
  }
}

data "terraform_remote_state" "network_TechByBellz_state" {
  backend = "azurerm"

  config = {
    use_oidc             = true
    tenant_id            = "8ff68f27-15e1-495a-9035-c162afc26e56"
    subscription_id      = "8493dc0b-b480-40dd-bef5-c47dce3a9348"
    resource_group_name  = "terraform-state-tbb-rg"
    storage_account_name = "terraformtbbstate7565"
    container_name       = "tfstate"
    key                  = "network/TechByBellz/terraform.tfstate"
  }
}

data "terraform_remote_state" "network_tfd_npd_state" {
  backend = "azurerm"

  config = {
    use_oidc             = true
    tenant_id            = "fd34fbf2-afa8-4adc-bef6-9f296fd46e66"
    resource_group_name  = "terraform-state-npd-cacn-rg"
    subscription_id      = "1eaee368-1764-4383-9c12-9a596a909bec"
    storage_account_name = "terraformnpdstate5984"
    container_name       = "tfstate"
    key                  = "network/tfd-npd/terraform.tfstate"
  }
}

data "terraform_remote_state" "network_tfd_prd_state" {
  backend = "azurerm"

  config = {
    use_oidc             = true
    tenant_id            = "fd34fbf2-afa8-4adc-bef6-9f296fd46e66"
    resource_group_name  = "terraform-state-prd-cacn-rg"
    subscription_id      = "9d36219a-89a8-448f-adcf-9fa9fa4cd328"
    storage_account_name = "terraformprdstate9402"
    container_name       = "tfstate"
    key                  = "network/tfd-prd/terraform.tfstate"
  }
}
