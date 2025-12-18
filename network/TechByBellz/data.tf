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
      subscription  = "tbb"
      vnet_prefix   = "shared_services"
      vnet_new_bits = 4
      subnets = [
        {
          subnet_prefix   = "AzureBastionSubnet"
          subnet_new_bits = "4" # /26
        }
      ]
      locations = ["cacn"]
    },
    {
      subscription  = "tbb"
      vnet_prefix   = "application-services"
      vnet_new_bits = 4
      subnets = [
        {
          subnet_prefix   = "app-test-subnet"
          subnet_new_bits = "7" # /29
        }
      ]
      locations = ["cacn"]
    }

  ]
  tbb_hub = [
    for net in local.network : net if lower(net.subscription) == "tbb"
  ]

  tbb_rg_names = {
    cacn = "bellzytech-hub-network-cacn-tbb-rg"
  }

  tbb_supernets = {
    cacn = "10.30.0.0/18"
  }
}



module "tbb_resource_group" {
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
