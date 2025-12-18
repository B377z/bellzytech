output "current_subscription" {
  value = module.tfd_npd_subscriptions.current
}

output "tfd_npd_vnet_map" {
  value = module.tfd_npd_network.tfd_npd_vnet_map
}
