variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

# =====================================
# LOG ANALYTICS
# =====================================

variable "log_analytics_workspace_name" {
  type = string
}

variable "log_analytics_sku" {
  type = string
}

variable "log_retention_in_days" {
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