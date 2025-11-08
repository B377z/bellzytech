terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

module "locations" {
  source = "../locations"
  providers = {
    azurerm = azurerm
  }
}

module "subscriptions" {
  source = "../subscriptions"
  providers = {
    azurerm = azurerm
  }
}

locals {
  locations = {
    for k, v in module.locations.location_by_code : k => v if(!var.primary_location_only || (var.primary_location_only && k == one(keys(module.locations.primary_location))))
  }

  resource_groups = {
    for k, v in local.locations : k => {
      name     = "${var.prefix}-${k}-${module.subscriptions.current.short_code}-rg"
      location = v
    }
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = local.resource_groups

  name     = each.value.name
  location = each.value.location
}

locals {
  role_assignment = flatten([
    for ra in var.role_assignments : [
      for r in ra.roles : [
        for k, g in azurerm_resource_group.rg : {
          key                  = replace("${ra.principal.name}-as-${r}-at-${g.name}", " ", "")
          principal_id         = ra.principal.principal_id
          scope                = g.id
          role_definition_name = r
          principal_type       = try(ra.principal.principal_type, null)
          skip_spn_check       = try(ra.principal.skip_spn_check, false)
        }
      ]
    ]
  ])
}

resource "azurerm_role_assignment" "role_assignment" {
  for_each = { for r in local.role_assignment : r.key => r }

  principal_id                     = each.value.principal_id
  scope                            = each.value.scope
  role_definition_name             = each.value.role_definition_name
  principal_type                   = each.value.principal_type
  skip_service_principal_aad_check = each.value.skip_spn_check
}
