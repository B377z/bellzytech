terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
}

data "azurerm_client_config" "client" {}

locals {
  # Static catalog of subs
  subscriptions = {
    TechByBellz = {
      id         = "8493dc0b-b480-40dd-bef5-c47dce3a9348"
      name       = "TechByBellz"
      short_code = "tbb"
    }
    Tfd-Npd = {
      id         = "1eaee368-1764-4383-9c12-9a596a909bec"
      name       = "Tfd-Npd"
      short_code = "npd"
    }
    Tfd-Prd = {
      id         = "9d36219a-89a8-448f-adcf-9fa9fa4cd328"
      name       = "Tfd-Prd"
      short_code = "prd"
    }
  }

  # Useful reshapes
  subs_list = [
    for key, v in local.subscriptions :
    merge(v, { key = key })
  ]

  subs_by_id = {
    for key, v in local.subscriptions :
    v.id => merge(v, { key = key })
  }

  current_base = try(local.subs_by_id[data.azurerm_client_config.client.subscription_id], null)
  current_full = local.current_base == null ? null : merge(
    local.current_base,
    {
      tenant_id    = data.azurerm_client_config.client.tenant_id
      principal_id = data.azurerm_client_config.client.object_id
    }
  )
}

# Outputs
output "all" {
  description = "All known subscriptions (list of objects)."
  value       = local.subs_list
}

output "by_id" {
  description = "Map of subscriptionId => subscription object."
  value       = local.subs_by_id
}

output "current" {
  description = "Current subscription (null if not in catalog) enriched with tenant/principal."
  value       = local.current_full
}
