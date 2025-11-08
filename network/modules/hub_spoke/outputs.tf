#############################
# Filter configs by subscription
#############################
locals {
  hub_cfgs = [for n in var.network_config : n if lower(n.subscription) == "hub"]
  npd_cfgs = [for n in var.network_config : n if lower(n.subscription) == "npd"]
  prd_cfgs = [for n in var.network_config : n if lower(n.subscription) == "prd"]
}

#############################
# HUB (TechByBellz)
#############################
output "tbb_vnet_map" {
  value = {
    for net in local.hub_cfgs : net.vnet_prefix => {
      for loc in net.locations : loc => {
        vnet = {
          key = "${var.hub_vnet_name_prefix}-${loc}"
          # only emit if the key exists (guards partial builds)
          id             = azurerm_virtual_network.tbb_hub["${net.vnet_prefix}-${loc}"].id
          name           = azurerm_virtual_network.tbb_hub["${net.vnet_prefix}-${loc}"].name
          location       = azurerm_virtual_network.tbb_hub["${net.vnet_prefix}-${loc}"].location
          address_space  = azurerm_virtual_network.tbb_hub["${net.vnet_prefix}-${loc}"].address_space
          resource_group = azurerm_virtual_network.tbb_hub["${net.vnet_prefix}-${loc}"].resource_group_name
        }
        subnets = {
          for snet in net.subnets :
          snet.subnet_prefix => {
            id               = azurerm_subnet.tbb_hub_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].id
            name             = azurerm_subnet.tbb_hub_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].name
            address_prefix   = azurerm_subnet.tbb_hub_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].address_prefixes[0]
            address_prefixes = azurerm_subnet.tbb_hub_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].address_prefixes
          }
          if contains(
            keys(azurerm_subnet.tbb_hub_subnets),
            "${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"
          )
        }
      }
      if contains(
        keys(azurerm_virtual_network.tbb_hub),
        "${net.vnet_prefix}-${loc}"
      )
    }
  }
}

#############################
# NPD (spoke)
#############################
output "tfd_npd_vnet_map" {
  value = {
    for net in local.npd_cfgs : net.vnet_prefix => {
      for loc in net.locations : loc => {
        vnet = {
          key            = "${var.npd_vnet_name_prefix}-${loc}"
          id             = azurerm_virtual_network.tfd_npd["${net.vnet_prefix}-${loc}"].id
          name           = azurerm_virtual_network.tfd_npd["${net.vnet_prefix}-${loc}"].name
          location       = azurerm_virtual_network.tfd_npd["${net.vnet_prefix}-${loc}"].location
          address_space  = azurerm_virtual_network.tfd_npd["${net.vnet_prefix}-${loc}"].address_space
          resource_group = azurerm_virtual_network.tfd_npd["${net.vnet_prefix}-${loc}"].resource_group_name
        }
        subnets = {
          for snet in net.subnets :
          snet.subnet_prefix => {
            id               = azurerm_subnet.tfd_npd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].id
            name             = azurerm_subnet.tfd_npd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].name
            address_prefix   = azurerm_subnet.tfd_npd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].address_prefixes[0]
            address_prefixes = azurerm_subnet.tfd_npd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].address_prefixes
          }
          if contains(
            keys(azurerm_subnet.tfd_npd_subnets),
            "${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"
          )
        }
      }
      if contains(
        keys(azurerm_virtual_network.tfd_npd),
        "${net.vnet_prefix}-${loc}"
      )
    }
  }
}

#############################
# PRD (spoke)
#############################
output "tfd_prd_vnet_map" {
  value = {
    for net in local.prd_cfgs : net.vnet_prefix => {
      for loc in net.locations : loc => {
        vnet = {
          key            = "${var.prd_vnet_name_prefix}-${loc}"
          id             = azurerm_virtual_network.tfd_prd["${net.vnet_prefix}-${loc}"].id
          name           = azurerm_virtual_network.tfd_prd["${net.vnet_prefix}-${loc}"].name
          location       = azurerm_virtual_network.tfd_prd["${net.vnet_prefix}-${loc}"].location
          address_space  = azurerm_virtual_network.tfd_prd["${net.vnet_prefix}-${loc}"].address_space
          resource_group = azurerm_virtual_network.tfd_prd["${net.vnet_prefix}-${loc}"].resource_group_name
        }
        subnets = {
          for snet in net.subnets :
          snet.subnet_prefix => {
            id               = azurerm_subnet.tfd_prd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].id
            name             = azurerm_subnet.tfd_prd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].name
            address_prefix   = azurerm_subnet.tfd_prd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].address_prefixes[0]
            address_prefixes = azurerm_subnet.tfd_prd_subnets["${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"].address_prefixes
          }
          if contains(
            keys(azurerm_subnet.tfd_prd_subnets),
            "${snet.subnet_prefix}-${loc}-${net.vnet_prefix}"
          )
        }
      }
      if contains(
        keys(azurerm_virtual_network.tfd_prd),
        "${net.vnet_prefix}-${loc}"
      )
    }
  }
}

