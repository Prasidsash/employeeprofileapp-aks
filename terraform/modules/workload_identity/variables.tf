# =====================================
# FEATURE TOGGLE
# =====================================

variable "enable_workload_identity_resources" {

  description = "Enable Workload Identity Resources"

  type = bool
}

# =====================================
# COMMON
# =====================================

variable "resource_group_name" {

  description = "Azure Resource Group Name"

  type = string
}

variable "location" {

  description = "Azure Region"

  type = string
}

variable "environment" {

  description = "Environment Name"

  type = string
}

# =====================================
# KUBERNETES
# =====================================

variable "namespace_name" {

  description = "Kubernetes Namespace"

  type = string
}

variable "service_account_name" {

  description = "Kubernetes ServiceAccount Name"

  type = string
}

# =====================================
# AKS OIDC
# =====================================

variable "oidc_issuer_url" {

  description = "AKS OIDC Issuer URL"

  type = string
}

# =====================================
# KEY VAULT
# =====================================

variable "key_vault_id" {

  description = "Azure Key Vault ID"

  type = string
}

# =====================================
# OPTIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional Tags"

  type = map(string)

  default = {}
}