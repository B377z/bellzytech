module "subscriptions" {
  source = "../modules/subscriptions"
  providers = {
    azurerm = azurerm.tfd_prd
  }
}

module "locations" {
  source = "../modules/locations"
  providers = {
    azurerm = azurerm.tfd_prd
  }
}

module "tfd_prd_network_rg" {
  source = "../modules/resource_group"
  providers = {
    azurerm = azurerm.tfd_prd
  }
  prefix                = "tfd-network"
  primary_location_only = true
  role_assignments = [
    {
      principal = {
        principal_id   = local.tfd_prd_sp.principal_id
        name           = "terraform-tfd-prd-sp"
        principal_type = "ServicePrincipal"
        skip_spn_check = true
      }

      roles = [
        "Contributor"
      ]
    }
  ]
}
