# =====================================
# FILE: terraform/modules/network/variables.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

# =====================================
# COMMON
# =====================================

variable "environment" {

  description = "Environment name"

  type = string
}

variable "location" {

  description = "Azure region"

  type = string
}

variable "resource_group_name" {

  description = "Azure Resource Group name"

  type = string
}

# =====================================
# VIRTUAL NETWORK
# =====================================

variable "vnet_name" {

  description = "Virtual Network name"

  type = string
}

variable "vnet_address_space" {

  description = "Virtual Network address space"

  type = list(string)
}

# =====================================
# AKS SUBNET
# =====================================

variable "aks_subnet_name" {

  description = "AKS subnet name"

  type = string
}

variable "aks_subnet_prefixes" {

  description = "AKS subnet prefixes"

  type = list(string)
}

# =====================================
# OPTIONAL NETWORK FEATURES
# =====================================

variable "service_endpoints" {

  description = "Optional subnet service endpoints"

  type = list(string)

  default = []
}

# =====================================
# OPTIONAL ADDITIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional network tags"

  type = map(string)

  default = {}
}