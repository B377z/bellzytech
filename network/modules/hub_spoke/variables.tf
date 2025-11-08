variable "location_names" {
  description = "Region code => Azure Location"
  type        = map(string)
}

# RG names per subscription, keyed by region code
variable "tbb_rg_names" {
  description = "Region code => Resource Group name for TechByBellz subscription"
  type        = map(string)
}

variable "tfd_prd_rg_names" {
  description = "Region code => Resource Group name for TFD Production subscription"
  type        = map(string)
}

variable "tfd_npd_rg_names" {
  description = "Region code => Resource Group name for TFD Non-Production subscription"
  type        = map(string)
}

# Supernets per subscription and region, keyed by region code
variable "tbb_supernets" {
  description = "Region code => Supernet CIDR for TechByBellz subscription"
  type        = map(string)
}

variable "tfd_prd_supernets" {
  description = "Region code => Supernet CIDR for TFD Production subscription"
  type        = map(string)
}

variable "tfd_npd_supernets" {
  description = "Region code => Supernet CIDR for TFD Non-Production subscription"
  type        = map(string)
}

# Declarative VNets per subscription and region
# subscription: tbb | tfd_prd | tfd_npd
variable "network_config" {
  description = <<-EOT
    [
      {
        subscription = "tbb"
        vnet_prefix  = "shared_services"
        vnet_new_bits = "4"
        subnets = [
          {
            subnet_prefix = "AzureBastionSubnet"
            subnet_new_bits = "4"
           }
        ]
        locations = ["cacn"]
      },
      {
        subscription   = "npd"
        vnet_prefix    = "application-services"
        vnet_new_bits  = "4"
        subnets = [
          {
            subnet_prefix   = "app-subnet"
            subnet_new_bits = "8"
          },
          {
            subnet_prefix   = "db-subnet"
            subnet_new_bits = "8"
          }
        ]
        locations = ["cacn"]
    }
    ]
    EOT
  type = list(object({
    subscription  = string
    vnet_prefix   = string
    vnet_new_bits = string
    subnets = list(object({
      subnet_prefix   = string
      subnet_new_bits = string
    }))
    locations = list(string)
  }))
}

variable "hub_vnet_name_prefix" {
  type    = string
  default = "tbb-hub-vnet"
}
variable "npd_vnet_name_prefix" {
  type    = string
  default = "tfd-npd-vnet"
}
variable "prd_vnet_name_prefix" {
  type    = string
  default = "tfd-prd-vnet"
}
