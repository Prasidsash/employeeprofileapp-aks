# =====================================
# Common
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
# Network
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
# Namespace
# =====================================

variable "namespace_name" {
  type = string
}

variable "namespace_labels" {
  type = map(string)
}

# =====================================
# Governance
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
# Secret
# =====================================

variable "secret_name" {
  type = string
}

# =====================================
# Ingress
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

# =====================================
# Helm
# =====================================

variable "release_name" {
  type = string
}

# =====================================
# Monitoring
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
# Module Toggles
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

variable "service_name" {
  type = string
}