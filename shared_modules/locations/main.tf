locals {
  locations = var.primary_location_only ? {
    cacn = "canadacentral"
    } : {
    cacn = "canadacentral"
    cace = "canadaeast"
  }
}
