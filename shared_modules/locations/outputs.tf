output "location_by_code" {
  description = "Location details by code"
  value       = local.locations
}

output "location_by_name" {
  description = "Location details by name"
  value       = { for code, name in local.locations : name => code }
}

output "primary_location" {
  description = "Primary location"
  value = {
    for code, name in local.locations : code => name if code == "cacn"
  }
}
