# =====================================
# FILE: terraform/modules/federated_identity/variables.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

variable "identity_name" {

  description = "User Assigned Identity name"

  type = string
}

variable "identity_resource_group_name" {

  description = "Identity resource group name"

  type = string
}

variable "user_assigned_identity_id" {

  description = "User Assigned Managed Identity ID"

  type = string
}

variable "namespace" {

  description = "Kubernetes namespace"

  type = string
}

variable "service_account_name" {

  description = "Kubernetes service account name"

  type = string
}

variable "oidc_issuer_url" {

  description = "AKS OIDC issuer URL"

  type = string
}

variable "resource_group_name" {

  description = "Azure Resource Group"

  type = string
}