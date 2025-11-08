variable "tfd_npd_sub_id" {
  description = "The subscription ID for the TFD NPD subscription"
  type        = string
}

variable "tfd_prd_sub_id" {
  description = "The subscription ID for the TFD PRD subscription"
  type        = string
}

variable "tfd_tenant_id" {
  description = "The tenant ID for the TFD subscriptions"
  type        = string
}

variable "tfd_npd_sp_id" {
  description = "The service principal ID for TFD NPD"
  type        = string
}

variable "tfd_npd_sp_secret" {
  description = "The service principal secret for TFD NPD"
  type        = string
  default     = null
}

variable "tfd_prd_sp_id" {
  description = "The service principal ID for TFD PRD"
  type        = string
}

variable "tfd_prd_sp_secret" {
  description = "The service principal secret for TFD PRD"
  type        = string
  default     = null
}

variable "techbybellz_sub_id" {
  description = "The subscription ID for the TechByBellz subscription"
  type        = string
}

variable "techbybellz_sp_id" {
  description = "The service principal ID for TechByBellz"
  type        = string
}

variable "techbybellz_sp_secret" {
  description = "The service principal secret for TechByBellz"
  type        = string
  default     = null
}

variable "techbybellz_tenant_id" {
  description = "The tenant ID for the TechByBellz subscription"
  type        = string
}
