output "current_subscription" {
  value = module.tfd_prd_subscriptions.current
}

output "tfd_prd_vnet_map" {
  value = module.tfd_npd_network.tfd_prd_vnet_map
}
