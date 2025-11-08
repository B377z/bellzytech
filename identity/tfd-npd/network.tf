module "subscriptions" {
  source = "../modules/subscriptions"
  providers = {
    azurerm = azurerm.tfd_npd
  }
}

module "locations" {
  source = "../modules/locations"
  providers = {
    azurerm = azurerm.tfd_npd
  }
}

module "tfd_npd_network_rg" {
  source = "../modules/resource_group"
  providers = {
    azurerm = azurerm.tfd_npd
  }
  prefix                = "tfd-network"
  primary_location_only = true
  role_assignments = [
    {
      principal = {
        principal_id   = local.tfd_npd_sp.principal_id
        name           = "terraform-tfd-npd-sp"
        principal_type = "ServicePrincipal"
        skip_spn_check = true
      }

      roles = [
        "Contributor"
      ]
    }
  ]
}
