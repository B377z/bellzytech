output "current_subscription" {
  value = module.tbb_subscriptions.current
}

output "tbb_vnet_map" {
  value = module.bellzytech_hub_network.tbb_vnet_map
}
