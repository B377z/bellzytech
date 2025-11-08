module "bellzytech_hub_network" {
  source = "../modules/hub_spoke"
  providers = {
    azurerm.techbybellz = azurerm.techbybellz
    azurerm.tfd_prd     = azurerm.tfd_prd
    azurerm.tfd_npd     = azurerm.tfd_npd
  }

  location_names   = local.location_names
  network_config   = local.tbb_hub
  tbb_rg_names     = local.tbb_rg_names
  tfd_prd_rg_names = {}
  tfd_npd_rg_names = {}

  tbb_supernets     = local.tbb_supernets
  tfd_prd_supernets = {}
  tfd_npd_supernets = {}
}
