output "tbb_network_rg_ids" {
  value = {
    for k, v in data.azurerm_resource_group.tbb_network_rg : k => v.id
  }
}

output "tfd_prd_network_rg_ids" {
  value = {
    for k, v in data.azurerm_resource_group.tfd_prd_network_rg : k => v.id
  }
}

output "tfd_npd_network_rg_ids" {
  value = {
    for k, v in data.azurerm_resource_group.tfd_npd_network_rg : k => v.id
  }
}

output "tbb_network_rg_names" {
  value = {
    for k, v in data.azurerm_resource_group.tbb_network_rg : k => v.name
  }
}

output "tfd_prd_network_rg_names" {
  value = {
    for k, v in data.azurerm_resource_group.tfd_prd_network_rg : k => v.name
  }
}

output "tfd_npd_network_rg_names" {
  value = {
    for k, v in data.azurerm_resource_group.tfd_npd_network_rg : k => v.name
  }
}
