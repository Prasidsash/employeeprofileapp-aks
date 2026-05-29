# =====================================
# FILE: terraform/modules/sql/variables.tf
# VERSION: v2-enterprise-keyvault-generated-sql-credentials-final
# =====================================

# =====================================
# COMMON
# =====================================

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
# SQL ENABLEMENT
# =====================================

variable "enable_sql_database" {

  description = "Enable Azure SQL Database deployment"

  type = bool

  default = false
}

# =====================================
# SQL SERVER
# =====================================

variable "sql_server_name" {

  description = "Azure SQL Server name"

  type = string
}

variable "sql_server_version" {

  description = "Azure SQL Server version"

  type = string

  default = "12.0"
}

# =====================================
# SQL DATABASE
# =====================================

variable "sql_database_name" {

  description = "Azure SQL Database name"

  type = string
}

variable "sql_database_sku_name" {

  description = "Azure SQL Database SKU name"

  type = string

  default = "Basic"
}

variable "sql_max_size_gb" {

  description = "Azure SQL Database maximum size in GB"

  type = number

  default = 2
}

# =====================================
# PUBLIC NETWORK ACCESS
# =====================================

variable "enable_sql_public_network_access" {

  description = "Enable Azure SQL public network access"

  type = bool

  default = true
}

# =====================================
# FIREWALL RULES
# =====================================

variable "enable_sql_firewall_rules" {

  description = "Enable Azure SQL firewall rules"

  type = bool

  default = true
}

variable "sql_firewall_rules" {

  description = "Azure SQL firewall rules"

  type = list(object({

    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))

  default = []
}

# =====================================
# OPTIONAL ADDITIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional Azure resource tags"

  type = map(string)

  default = {}
}