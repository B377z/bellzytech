output "location_by_code" {
  description = "Region map keyed by code."
  value       = module.locations.location_by_code
}

output "location_by_name" {
  description = "Region map keyed by name."
  value       = module.locations.location_by_name
}

output "primary_location" {
  description = "Primary region only (1-item map)."
  value       = module.locations.primary_location
}
