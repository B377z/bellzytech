variable "location_codes" {
  description = "Map of location codes to Azure regions."
  type        = map(string)
}

variable "tbb_sub_short_name" {
  description = "Short name for the TechByBellz subscription."
  type        = string
}

variable "tfd_prd_sub_short_name" {
  description = "Short name for the TFD Production subscription."
  type        = string
}

variable "tfd_npd_sub_short_name" {
  description = "Short name for the TFD Non-Production subscription."
  type        = string
}
