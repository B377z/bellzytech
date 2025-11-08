variable "primary_location_only" {
  description = "If true, only return the primary location"
  type        = bool
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "role_assignments" {
  type = list(object({
    principal = object({
      principal_id   = string
      name           = string
      principal_type = optional(string)
      skip_spn_check = optional(bool)
    })
    roles = list(string)
  }))

  # Make sure each principal appears at most once in role_assignments
  validation {
    condition = length(distinct([
      for ra in var.role_assignments : ra.principal.principal_id
    ])) == length(var.role_assignments)
    error_message = "Duplicate principal_id found in role_assignments."
  }

  default = []
}
