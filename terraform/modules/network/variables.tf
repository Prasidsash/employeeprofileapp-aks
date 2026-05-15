variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "aks_subnet_name" {
  type = string
}

variable "aks_subnet_prefixes" {
  type = list(string)
}

# =====================================
# Optional Future Networking Features
# =====================================

variable "service_endpoints" {

  description = "Optional subnet service endpoints"

  type = list(string)

  default = []
}