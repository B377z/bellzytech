module "tbb_locations" {
  source = "../modules/locations"
  providers = {
    azurerm = azurerm.techbybellz
  }
}

module "tbb_subscriptions" {
  source = "../modules/subscriptions"
  providers = {
    azurerm = azurerm.techbybellz
  }
}

module "bellzytech_network_rg" {
  source = "../modules/resource_group"
  providers = {
    azurerm = azurerm.techbybellz
  }
  prefix = "bellzytech-hub-network"

  primary_location_only = true

  role_assignments = [
    {
      principal = {
        principal_id   = local.techbybellzsp.principal_id
        name           = "terraform-tbb-sp"
        principal_type = "ServicePrincipal"
        skip_spn_check = true
      }

      roles = [
        "Contributor"
      ]
    }
  ]
}
