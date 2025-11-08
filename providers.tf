# ---------- Tenant A (NPD + PRD) ----------
provider "azurerm" {
  alias = "tfd_npd"
  features {
    key_vault { purge_soft_delete_on_destroy = false }
  }
  subscription_id = var.tfd_npd_sub_id
  tenant_id       = var.tfd_tenant_id

  # Auth option A (preferred in CI): OIDC (no secrets)
  use_oidc  = true
  client_id = var.tfd_npd_sp_id

  # Auth option B (fallback): client secret
  # client_secret = var.tfd_npd_sp_secret
}

provider "azurerm" {
  alias = "tfd_prd"
  features {
    key_vault { purge_soft_delete_on_destroy = false }
  }
  subscription_id = var.tfd_prd_sub_id
  tenant_id       = var.tfd_tenant_id

  # Auth option A (preferred in CI): OIDC (no secrets)
  use_oidc  = true
  client_id = var.tfd_prd_sp_id

  # Auth option B (fallback): client secret
  # client_secret = var.tfd_prd_sp_secret
}

provider "azuread" {
  alias     = "tfd_ad_npd"
  tenant_id = var.tfd_tenant_id
  use_oidc  = true
  client_id = var.tfd_npd_sp_id
}

provider "azuread" {
  alias     = "tfd_ad_prd"
  tenant_id = var.tfd_tenant_id
  use_oidc  = true
  client_id = var.tfd_prd_sp_id
}

# ---------- Tenant B (TBB) ----------
provider "azurerm" {
  alias = "techbybellz"
  features {
    key_vault { purge_soft_delete_on_destroy = false }
  }
  subscription_id = var.techbybellz_sub_id
  tenant_id       = var.techbybellz_tenant_id
  use_oidc        = true
  client_id       = var.techbybellz_sp_id

  # Auth option B (fallback): client secret
  # client_secret = var.techbybellz_sp_secret
}

provider "azuread" {
  alias     = "techbybellzad"
  tenant_id = var.techbybellz_tenant_id
  use_oidc  = true
  client_id = var.techbybellz_sp_id
}
