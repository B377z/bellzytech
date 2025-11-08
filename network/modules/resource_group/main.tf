terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      configuration_aliases = [
        azurerm.techbybellz,
        azurerm.tfd_prd,
        azurerm.tfd_npd
      ]
    }
  }
}


data "azurerm_resource_group" "tbb_network_rg" {
  provider = azurerm.techbybellz
  for_each = var.location_codes

  name = "bellzytech-hub-network-${each.key}-${var.tbb_sub_short_name}-rg"
}

data "azurerm_resource_group" "tfd_prd_network_rg" {
  provider = azurerm.tfd_prd
  for_each = var.location_codes

  name = "tfd-network-${each.key}-${var.tfd_prd_sub_short_name}-rg"
}

data "azurerm_resource_group" "tfd_npd_network_rg" {
  provider = azurerm.tfd_npd
  for_each = var.location_codes

  name = "tfd-network-${each.key}-${var.tfd_npd_sub_short_name}-rg"
}
