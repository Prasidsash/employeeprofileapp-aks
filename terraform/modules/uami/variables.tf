# =====================================
# FILE:
# terraform/modules/uami/variables.tf
# VERSION:
# v3-enterprise-workloadidentity-federated-runtime-final
# =====================================

variable "identity_name" {

  description = "User Assigned Managed Identity name"

  type = string
}

variable "resource_group_name" {

  description = "Azure Resource Group name"

  type = string
}

variable "location" {

  description = "Azure region"

  type = string
}

variable "environment" {

  description = "Environment name"

  type = string
}

# =====================================
# FEDERATED IDENTITY
# =====================================

variable "enable_federated_identity" {

  description = "Enable Federated Identity Credential"

  type = bool

  default = true
}

variable "namespace_name" {

  description = "Kubernetes Namespace"

  type = string

  default = "employeeprofileapp-dev"
}

variable "service_account_name" {

  description = "Kubernetes Service Account Name"

  type = string

  default = "employee-sa"
}

variable "oidc_issuer_url" {

  description = "AKS OIDC Issuer URL"

  type = string

  default = null
}

variable "key_vault_id" {

  description = "Azure Key Vault Resource ID"

  type = string

  default = null
}

# =====================================
# TAGS
# =====================================

variable "additional_tags" {

  description = "Additional resource tags"

  type = map(string)

  default = {}
}