output "all" {
  value = azurerm_resource_group.rg
}

output "primary" {
  value = azurerm_resource_group.rg[one(keys(module.locations.primary_location))]
}
