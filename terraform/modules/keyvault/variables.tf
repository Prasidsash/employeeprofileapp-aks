# =====================================
# COMMON
# =====================================

variable "resource_group_name" {

  description = "Resource Group Name"

  type = string
}

variable "location" {

  description = "Azure Region"

  type = string
}

variable "environment" {

  description = "Environment name"

  type = string
}

# =====================================
# OPTIONAL FUTURE OVERRIDE
# Existing implementation currently
# uses generated local value
# =====================================

variable "key_vault_name" {

  description = "Optional custom Key Vault name override"

  type = string

  default = null
}

# =====================================
# KEY VAULT RBAC
# =====================================

variable "keyvault_admin_object_id" {

  description = "Stable Object ID for Key Vault Administrator role assignment"

  type = string
}