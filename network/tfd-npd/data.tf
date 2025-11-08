module "locations" {
  source = "../modules/locations"
}

module "tbb_subscriptions" {
  source = "../modules/subscriptions"
  providers = {
    azurerm = azurerm.techbybellz
  }
}

module "tfd_prd_subscriptions" {
  source = "../modules/subscriptions"
  providers = {
    azurerm = azurerm.tfd_prd
  }
}

module "tfd_npd_subscriptions" {
  source = "../modules/subscriptions"
  providers = {
    azurerm = azurerm.tfd_npd
  }
}

locals {
  selected_region = module.locations.primary_location
  location_names  = module.locations.location_by_code
  network = [
    {
      subscription  = "tfd_npd"
      vnet_prefix   = "application_services"
      vnet_new_bits = 4
      subnets       = []
      locations     = ["cacn"]
    }
  ]

  tfd_npd = [
    for net in local.network : net if lower(net.subscription) == "tfd_npd"
  ]

  tfd_npd_rg_names = {
    cacn = "tfd-network-cacn-npd-rg"
  }

  tfd_npd_supernets = {
    cacn = "10.90.0.0/18"
  }
}



module "tfd_npd_resource_group" {
  source = "../modules/resource_group"
  providers = {
    azurerm.techbybellz = azurerm.techbybellz
    azurerm.tfd_prd     = azurerm.tfd_prd
    azurerm.tfd_npd     = azurerm.tfd_npd
  }

  location_codes = local.selected_region

  tbb_sub_short_name     = module.tbb_subscriptions.current.short_code
  tfd_prd_sub_short_name = module.tfd_prd_subscriptions.current.short_code
  tfd_npd_sub_short_name = module.tfd_npd_subscriptions.current.short_code
}
