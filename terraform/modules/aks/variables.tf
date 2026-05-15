# =====================================
# COMMON
# =====================================

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
# AKS CLUSTER
# =====================================

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

# =====================================
# SYSTEM NODE POOL
# =====================================

variable "system_node_count" {
  type = number
}

variable "system_node_vm_size" {
  type = string
}

variable "subnet_id" {
  type = string
}

# =====================================
# NETWORKING
# =====================================

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

# =====================================
# LOG ANALYTICS
# =====================================

variable "log_analytics_workspace_id" {

  description = "Log Analytics Workspace ID"

  type = string
}

# =====================================
# MANAGED PROMETHEUS
# =====================================

variable "azure_monitor_workspace_id" {

  description = "Azure Monitor Workspace ID"

  type = string

  default = null
}

# =====================================
# NODE AUTOSCALING
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
# OPTIONAL WORKLOAD IDENTITY
# =====================================

variable "enable_workload_identity" {

  description = "Enable AKS Workload Identity"

  type = bool

  default = false
}

# =====================================
# OPTIONAL OIDC ISSUER
# =====================================

variable "enable_oidc_issuer" {

  description = "Enable AKS OIDC Issuer"

  type = bool

  default = false
}

# =====================================
# OPTIONAL IMAGE CLEANER
# =====================================

variable "enable_image_cleaner" {

  description = "Enable AKS Image Cleaner"

  type = bool

  default = false
}

variable "image_cleaner_interval_hours" {

  description = "AKS Image Cleaner Interval"

  type = number

  default = 48
}

# =====================================
# OPTIONAL SKU TIER
# =====================================

variable "sku_tier" {

  description = "AKS SKU Tier"

  type = string

  default = "Free"
}

# =====================================
# OPTIONAL NODE LABELS
# =====================================

variable "node_labels" {

  description = "Optional AKS node labels"

  type = map(string)

  default = {}
}

# =====================================
# OPTIONAL NODE TAINTS
# =====================================

variable "node_taints" {

  description = "Optional AKS node taints"

  type = list(string)

  default = []
}

# =====================================
# OPTIONAL API SERVER ACCESS PROFILE
# =====================================

variable "enable_api_server_access_profile" {

  description = "Enable AKS API server access profile"

  type = bool

  default = false
}

variable "authorized_ip_ranges" {

  description = "Authorized IP ranges for AKS API server"

  type = list(string)

  default = []
}

# =====================================
# OPTIONAL ADDITIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional AKS tags"

  type = map(string)

  default = {}
}