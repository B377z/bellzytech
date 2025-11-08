locals {
  network = [

  ]

  tbb_hub = [
    for net in local.network : net if lower(net.subscription) == "tbb"
  ]
  tfd_npd = [
    for net in local.network : net if lower(net.subscription) == "tfd_npd"
  ]
  tfd_prd = [
    for net in local.network : net if lower(net.subscription) == "tfd_prd"
  ]

  tbb_rg_names = {
    cacn = "bellzytech-hub-network-cacn-tbb-rg"
  }
  tfd_npd_rg_names = {
    cacn = "tfd-network-cacn-npd-rg"
  }
  tfd_prd_rg_names = {
    cacn = "tfd-network-cacn-prd-rg"
  }

  tbb_supernets = {
    cacn = "10.30.0.0/18"
  }
  tfd_npd_supernets = {
    cacn = "10.60.0.0/18"
  }
  tfd_prd_supernets = {
    cacn = "10.90.0.0/18"
  }
}
