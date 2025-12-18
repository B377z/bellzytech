terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      configuration_aliases = [
        azurerm.techbybellz, # hub
        azurerm.tfd_npd,     # npd
        azurerm.tfd_prd,     # prd
      ]
    }
  }
}

locals {
  # Index VNets to get a stable vnet netnum per subscription group
  vnets_indexed = {
    for idx, net in var.network_config : idx => net
  }

  # Expand to vnet, region records
  vnet_matrix = flatten([
    for idx, cfg in local.vnets_indexed : [
      for loc in cfg.locations : {
        key = "${cfg.vnet_prefix}-${loc}"
        idx = idx
        cfg = cfg
        loc = loc
      }
    ]
  ])

  # Split by subscription for provider-bound resources
  tbb_hub_vnets = {
    for vnet in local.vnet_matrix : vnet.key => vnet
    if vnet.cfg.subscription == "tbb"
  }
  tfd_npd_vnets = {
    for vnet in local.vnet_matrix : vnet.key => vnet
    if vnet.cfg.subscription == "tfd_npd"
  }
  tfd_prd_vnets = {
    for vnet in local.vnet_matrix : vnet.key => vnet
    if vnet.cfg.subscription == "tfd_prd"
  }

  # Subnets per subscription group
  tbb_hub_subnets = {
    for y in flatten([
      for v in local.tbb_hub_vnets : [
        for sidx, snet in v.cfg.subnets : {
          key      = "${snet.subnet_prefix}-${v.loc}-${v.cfg.vnet_prefix}"
          vnet_key = v.key
          vnet_idx = v.idx
          loc      = v.loc
          vnet_cfg = v.cfg
          subnet   = snet
          sidx     = sidx
        }
      ]
    ]) : y.key => y
  }

  tfd_npd_subnets = {
    for y in flatten([
      for v in local.tfd_npd_vnets : [
        for sidx, snet in v.cfg.subnets : {
          key      = "${snet.subnet_prefix}-${v.loc}-${v.cfg.vnet_prefix}"
          vnet_key = v.key
          vnet_idx = v.idx
          loc      = v.loc
          vnet_cfg = v.cfg
          subnet   = snet
          sidx     = sidx
        }
      ]
    ]) : y.key => y
  }

  tfd_prd_subnets = {
    for y in flatten([
      for v in local.tfd_prd_vnets : [
        for sidx, snet in v.cfg.subnets : {
          key      = "${snet.subnet_prefix}-${v.loc}-${v.cfg.vnet_prefix}"
          vnet_key = v.key
          vnet_idx = v.idx
          loc      = v.loc
          vnet_cfg = v.cfg
          subnet   = snet
          sidx     = sidx
        }
      ]
    ]) : y.key => y
  }

  tbb_intra_peerings = {
    for vnet_key, v in local.tbb_hub_vnets :
    vnet_key => {
      loc       = v.loc
      hub_key   = "shared_services-${v.loc}"
      spoke_key = vnet_key
    }

    if v.cfg.vnet_prefix != "shared_services"
  }
}

resource "azurerm_virtual_network" "tbb_hub" {
  provider            = azurerm.techbybellz
  for_each            = local.tbb_hub_vnets
  name                = "${var.hub_vnet_name_prefix}-${each.value.cfg.vnet_prefix}-${each.value.loc}"
  location            = var.location_names[each.value.loc]
  resource_group_name = var.tbb_rg_names[each.value.loc]
  address_space = [
    cidrsubnet(
      var.tbb_supernets[each.value.loc],
      tonumber(each.value.cfg.vnet_new_bits),
      each.value.idx
    )
  ]
  tags = {
    role   = "hub",
    region = each.value.loc,
    vnet   = each.value.cfg.vnet_prefix
  }
}

resource "azurerm_virtual_network" "tfd_npd" {
  provider            = azurerm.tfd_npd
  for_each            = local.tfd_npd_vnets
  name                = "${var.npd_vnet_name_prefix}-${each.value.loc}"
  location            = var.location_names[each.value.loc]
  resource_group_name = var.tfd_npd_rg_names[each.value.loc]
  address_space = [
    cidrsubnet(
      var.tfd_npd_supernets[each.value.loc],
      tonumber(each.value.cfg.vnet_new_bits),
      each.value.idx
    )
  ]
  tags = {
    role   = "spoke",
    region = each.value.loc,
    vnet   = each.value.cfg.vnet_prefix,
    env    = "tfd_npd"
  }
}

resource "azurerm_virtual_network" "tfd_prd" {
  provider            = azurerm.tfd_prd
  for_each            = local.tfd_prd_vnets
  name                = "${var.prd_vnet_name_prefix}-${each.value.loc}"
  location            = var.location_names[each.value.loc]
  resource_group_name = var.tfd_prd_rg_names[each.value.loc]
  address_space = [
    cidrsubnet(
      var.tfd_prd_supernets[each.value.loc],
      tonumber(each.value.cfg.vnet_new_bits),
      each.value.idx
    )
  ]
  tags = {
    role   = "spoke",
    region = each.value.loc,
    vnet   = each.value.cfg.vnet_prefix,
    env    = "tfd_prd"
  }
}

resource "azurerm_subnet" "tbb_hub_subnets" {
  provider             = azurerm.techbybellz
  for_each             = local.tbb_hub_subnets
  name                 = each.value.subnet.subnet_prefix
  resource_group_name  = var.tbb_rg_names[each.value.loc]
  virtual_network_name = azurerm_virtual_network.tbb_hub[each.value.vnet_key].name
  address_prefixes = [
    cidrsubnet(
      tolist(azurerm_virtual_network.tbb_hub[each.value.vnet_key].address_space)[0],
      tonumber(each.value.subnet.subnet_new_bits),
      each.value.sidx
    )
  ]
}

resource "azurerm_subnet" "tfd_npd_subnets" {
  provider             = azurerm.tfd_npd
  for_each             = local.tfd_npd_subnets
  name                 = each.value.subnet.subnet_prefix
  resource_group_name  = var.tfd_npd_rg_names[each.value.loc]
  virtual_network_name = azurerm_virtual_network.tfd_npd[each.value.vnet_key].name
  address_prefixes = [
    cidrsubnet(
      tolist(azurerm_virtual_network.tfd_npd[each.value.vnet_key].address_space)[0],
      tonumber(each.value.subnet.subnet_new_bits),
      each.value.sidx
    )
  ]
}

resource "azurerm_subnet" "tfd_prd_subnets" {
  provider             = azurerm.tfd_prd
  for_each             = local.tfd_prd_subnets
  name                 = each.value.subnet.subnet_prefix
  resource_group_name  = var.tfd_prd_rg_names[each.value.loc]
  virtual_network_name = azurerm_virtual_network.tfd_prd[each.value.vnet_key].name
  address_prefixes = [
    cidrsubnet(
      tolist(azurerm_virtual_network.tfd_prd[each.value.vnet_key].address_space)[0],
      tonumber(each.value.subnet.subnet_new_bits),
      each.value.sidx
    )
  ]
}

# TBB shared_services (hub) → TBB application-services (spoke)
resource "azurerm_virtual_network_peering" "tbb_hub_shr_to_app" {
  provider                     = azurerm.techbybellz
  for_each                     = local.tbb_intra_peerings
  name                         = "tbb-shr-to-app-${each.value.loc}"
  resource_group_name          = var.tbb_rg_names[each.value.loc]
  virtual_network_name         = azurerm_virtual_network.tbb_hub[each.value.hub_key].name
  remote_virtual_network_id    = azurerm_virtual_network.tbb_hub[each.value.spoke_key].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# TBB application-services (spoke) → TBB shared_services (hub)
resource "azurerm_virtual_network_peering" "tbb_app_to_hub" {
  provider = azurerm.techbybellz
  for_each = local.tbb_intra_peerings

  name                      = "tbb-app-to-shr-${each.value.loc}"
  resource_group_name       = var.tbb_rg_names[each.value.loc]
  virtual_network_name      = azurerm_virtual_network.tbb_hub[each.value.spoke_key].name
  remote_virtual_network_id = azurerm_virtual_network.tbb_hub[each.value.hub_key].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
