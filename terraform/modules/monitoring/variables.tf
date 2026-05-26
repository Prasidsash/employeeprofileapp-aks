# =====================================
# FILE: terraform/modules/monitoring/variables.tf
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
# LOG ANALYTICS
# =====================================

variable "log_analytics_workspace_name" {

  description = "Log Analytics Workspace Name"

  type = string
}

variable "log_analytics_sku" {

  description = "Log Analytics SKU"

  type = string
}

variable "log_retention_in_days" {

  description = "Log retention in days"

  type = number
}

# =====================================
# OPTIONAL ALERT SETTINGS
# =====================================

variable "enable_alerts" {

  description = "Enable Azure Monitor alerts"

  type = bool

  default = false
}

variable "aks_cluster_id" {

  description = "AKS resource ID"

  type = string

  default = null
}

# =====================================
# MANAGED PROMETHEUS / GRAFANA
# =====================================

variable "enable_managed_prometheus" {

  description = "Enable Azure Managed Prometheus and Grafana"

  type = bool

  default = false
}

# =====================================
# OPTIONAL GRAFANA SETTINGS
# =====================================

variable "grafana_major_version" {

  description = "Azure Managed Grafana major version"

  type = number

  default = 11
}

variable "grafana_api_key_enabled" {

  description = "Enable Grafana API keys"

  type = bool

  default = false
}

# =====================================
# OPTIONAL ADDITIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional monitoring tags"

  type = map(string)

  default = {}
}