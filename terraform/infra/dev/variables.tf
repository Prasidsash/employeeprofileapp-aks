# =====================================
# COMMON
# =====================================

variable "environment" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

# =====================================
# NETWORK
# =====================================

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "aks_subnet_name" {
  type = string
}

variable "aks_subnet_prefixes" {
  type = list(string)
}

# =====================================
# AKS
# =====================================

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "system_node_count" {
  type = number
}

variable "system_node_vm_size" {
  type = string
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

# =====================================
# AKS AUTOSCALING
# =====================================

variable "enable_node_autoscaling" {
  type = bool
}

variable "system_node_min_count" {
  type = number
}

variable "system_node_max_count" {
  type = number
}

# =====================================
# NAMESPACE
# =====================================

variable "namespace_name" {
  type = string
}

variable "namespace_labels" {
  type = map(string)
}

# =====================================
# GOVERNANCE
# =====================================

variable "quota_limits" {
  type = map(string)
}

variable "limit_max" {
  type = map(string)
}

variable "limit_min" {
  type = map(string)
}

variable "limit_default" {
  type = map(string)
}

variable "limit_default_request" {
  type = map(string)
}

# =====================================
# RBAC
# =====================================

variable "service_account_name" {
  type = string
}

variable "role_name" {
  type = string
}

variable "allowed_resources" {
  type = list(string)
}

variable "allowed_verbs" {
  type = list(string)
}

# =====================================
# SECRET
# =====================================

variable "secret_name" {
  type = string
}

variable "secret_data" {

  type      = map(string)
  sensitive = true
  default   = {}
}

# =====================================
# KEY VAULT RBAC
# =====================================

variable "keyvault_admin_object_id" {

  description = "Stable Object ID for Key Vault Administrator RBAC assignment"

  type = string
}

# =====================================
# INGRESS
# =====================================

variable "ingress_name" {
  type = string
}

variable "ingress_host" {
  type = string
}

variable "ingress_path" {
  type = string
}

variable "ingress_path_type" {
  type = string
}

variable "service_name" {
  type = string
}

# =====================================
# TLS / HTTPS
# =====================================

variable "enable_tls" {

  description = "Enable HTTPS ingress"

  type = bool

  default = false
}

variable "tls_secret_name" {

  description = "TLS Secret"

  type = string

  default = null
}

# =====================================
# HELM
# =====================================

variable "release_name" {
  type = string
}

# =====================================
# MONITORING
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

variable "enable_alerts" {

  description = "Enable Azure Monitor Alerts"

  type = bool

  default = false
}

variable "enable_managed_prometheus" {

  description = "Enable Azure Managed Prometheus and Grafana"

  type = bool

  default = false
}

# =====================================
# FEATURE TOGGLES
# =====================================

variable "enable_network" {
  type = bool
}

variable "enable_aks" {
  type = bool
}

variable "enable_namespace" {
  type = bool
}

variable "enable_rbac" {
  type = bool
}

variable "enable_governance" {
  type = bool
}

variable "enable_secret" {
  type = bool
}

variable "enable_ingress" {
  type = bool
}

variable "enable_monitoring" {
  type = bool
}

variable "enable_hpa" {

  description = "Enable Horizontal Pod Autoscaler"

  type = bool

  default = false
}

variable "enable_loadbalancer" {

  description = "Enable LoadBalancer"

  type = bool

  default = true
}