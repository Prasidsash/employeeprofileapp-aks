# =====================================
# COMMON
# =====================================

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "environment" {
  type = string
}

# =====================================
# AKS VERSION
# =====================================

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
# NETWORKING
# =====================================

variable "subnet_id" {
  type = string
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

# =====================================
# MONITORING
# =====================================

variable "log_analytics_workspace_id" {
  type = string
}

variable "azure_monitor_workspace_id" {
  type    = string
  default = null
}

# =====================================
# OPTIONAL WORKLOAD IDENTITY
# =====================================

variable "enable_workload_identity" {

  description = "Enable AKS Workload Identity"

  type = bool

  default = false
}

variable "enable_oidc_issuer" {

  description = "Enable AKS OIDC Issuer"

  type = bool

  default = false
}

# =====================================
# OPTIONAL KEY VAULT CSI DRIVER
# =====================================

variable "enable_key_vault_secrets_provider" {

  description = "Enable Azure Key Vault CSI Driver"

  type = bool

  default = false
}

variable "secret_rotation_enabled" {

  description = "Enable Azure Key Vault secret rotation"

  type = bool

  default = true
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
# NODE LABELS / TAINTS
# =====================================

variable "node_labels" {

  description = "Optional AKS node labels"

  type = map(string)

  default = {}
}

variable "node_taints" {

  description = "Optional AKS node taints"

  type = list(string)

  default = []
}

# =====================================
# API SERVER ACCESS PROFILE
# =====================================

variable "enable_api_server_access_profile" {

  description = "Enable AKS API server access profile"

  type = bool

  default = false
}

variable "authorized_ip_ranges" {

  description = "Authorized IP ranges"

  type = list(string)

  default = []
}

# =====================================
# ADDITIONAL TAGS
# =====================================

variable "additional_tags" {

  description = "Additional AKS tags"

  type = map(string)

  default = {}
}

# =====================================
# SPOT NODE POOL
# =====================================

variable "enable_spot_node_pool" {

  description = "Enable AKS Spot node pool"

  type = bool

  default = false
}

variable "spot_node_pool_name" {

  description = "AKS Spot node pool name"

  type = string

  default = "spotpool"
}

variable "spot_node_vm_size" {

  description = "AKS Spot node VM size"

  type = string

  default = "Standard_D2s_v3"
}

variable "spot_max_price" {

  description = "Maximum Spot node price"

  type = number

  default = -1
}

variable "spot_node_min_count" {

  description = "Minimum Spot node count"

  type = number

  default = 0
}

variable "spot_node_max_count" {

  description = "Maximum Spot node count"

  type = number

  default = 2
}

variable "spot_node_labels" {

  description = "Spot node labels"

  type = map(string)

  default = {}
}

variable "spot_node_taints" {

  description = "Spot node taints"

  type = list(string)

  default = []
}

# =====================================
# OPTIONAL USER-ASSIGNED MANAGED IDENTITY
# FOR FUTURE WORKLOAD IDENTITY EXPANSION
# =====================================

variable "enable_user_assigned_identity" {

  description = "Enable User Assigned Managed Identity"

  type = bool

  default = false
}

variable "user_assigned_identity_ids" {

  description = "User Assigned Managed Identity IDs"

  type = list(string)

  default = []
}