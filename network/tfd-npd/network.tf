module "tfd_npd_network" {
  source = "../modules/hub_spoke"
  providers = {
    azurerm.techbybellz = azurerm.techbybellz
    azurerm.tfd_prd     = azurerm.tfd_prd
    azurerm.tfd_npd     = azurerm.tfd_npd
  }

  location_names   = local.location_names
  network_config   = local.tfd_npd
  tbb_rg_names     = {}
  tfd_prd_rg_names = {}
  tfd_npd_rg_names = local.tfd_npd_rg_names

  tbb_supernets     = {}
  tfd_prd_supernets = {}
  tfd_npd_supernets = local.tfd_npd_supernets
}
