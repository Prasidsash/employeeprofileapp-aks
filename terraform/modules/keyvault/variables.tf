# =====================================
# FILE: terraform/modules/keyvault/variables.tf
# VERSION: v6-enterprise-disposable-stable
# =====================================

# =====================================
# BOOTSTRAP SECRETS
# =====================================

variable "enable_bootstrap_secrets" {

  description = "Enable bootstrap Key Vault secrets"

  type = bool

  default = false
}

variable "bootstrap_secrets" {

  description = "Bootstrap Key Vault secrets"

  type = map(string)

  default = {}
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
# OPTIONAL CUSTOM KEY VAULT NAME
# =====================================

variable "key_vault_name" {

  description = "Optional custom Azure Key Vault name override"

  type = string

  default = null
}

# =====================================
# KEY VAULT ADMIN RBAC
# =====================================

variable "keyvault_admin_object_id" {

  description = "Azure AD Object ID for Key Vault Administrator RBAC assignment"

  type = string

  default = null
}

# =====================================
# AKS CSI DRIVER RBAC
# =====================================

variable "enable_aks_kv_rbac" {

  description = "Enable AKS managed identity access to Azure Key Vault"

  type = bool

  default = true
}

variable "aks_kubelet_object_id" {

  description = "AKS kubelet managed identity object ID"

  type = string

  default = null
}

# =====================================
# WORKLOAD IDENTITY KEYVAULT ACCESS
# =====================================

variable "enable_workload_identity_keyvault_access" {

  description = "Enable workload identity access to Azure Key Vault"

  type = bool

  default = true
}

variable "workload_identity_principal_id" {

  description = "User Assigned Managed Identity Principal ID"

  type = string

  default = null
}

# =====================================
# OPTIONAL NETWORK ACLS
# =====================================

variable "enable_network_acls" {

  description = "Enable Azure Key Vault network ACLs"

  type = bool

  default = false
}

# =====================================
# OPTIONAL ADDITIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional Azure resource tags"

  type = map(string)

  default = {}
}

# =====================================
# PURGE PROTECTION
# =====================================

variable "enable_purge_protection" {

  description = "Enable Azure Key Vault purge protection"

  type = bool

  default = false
}

# =====================================
# SOFT DELETE RETENTION
# =====================================

variable "soft_delete_retention_days" {

  description = "Azure Key Vault soft delete retention days"

  type = number

  default = 7
}

# =====================================
# DEFAULT KEY VAULT SECRETS
# =====================================

variable "enable_default_key_vault_secrets" {

  description = "Enable automatic default Azure Key Vault secret creation"

  type = bool

  default = true
}

# =====================================
# DATABASE SECRETS
# =====================================

variable "db_username" {

  description = "Database username secret"

  type = string

  sensitive = true
}

variable "db_password" {

  description = "Database password secret"

  type = string

  sensitive = true
}