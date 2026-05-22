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

# =====================================
# OPTIONAL ROLE OVERRIDE
# =====================================

variable "keyvault_role_definition_name" {

  description = "Optional Key Vault RBAC role definition"

  type = string

  default = "Key Vault Administrator"
}

# =====================================
# OPTIONAL NETWORK ACL SUPPORT
# =====================================

variable "enable_network_acls" {

  description = "Enable Key Vault network ACL block"

  type = bool

  default = false
}

# =====================================
# OPTIONAL ADDITIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional Key Vault tags"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL PURGE PROTECTION
# =====================================

variable "enable_purge_protection" {

  description = "Enable Key Vault purge protection"

  type = bool

  default = false
}

# =====================================
# OPTIONAL SOFT DELETE RETENTION
# =====================================

variable "soft_delete_retention_days" {

  description = "Key Vault soft delete retention days"

  type = number

  default = 7
}