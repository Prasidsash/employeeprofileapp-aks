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

variable "cluster_name" {

  description = "AKS cluster name"

  type = string
}

variable "environment" {

  description = "Environment name"

  type = string
}

# =====================================
# AKS VERSION
# =====================================

variable "kubernetes_version" {

  description = "AKS Kubernetes version"

  type = string
}

# =====================================
# SYSTEM NODE POOL
# =====================================

variable "system_node_count" {

  description = "System node count"

  type = number
}

variable "system_node_vm_size" {

  description = "System node VM size"

  type = string
}

variable "enable_node_autoscaling" {

  description = "Enable AKS node autoscaling"

  type = bool
}

variable "system_node_min_count" {

  description = "Minimum system node count"

  type = number
}

variable "system_node_max_count" {

  description = "Maximum system node count"

  type = number
}

variable "only_critical_addons_enabled" {

  description = "Allow only critical addons on system node pool"

  type = bool

  default = false
}

# =====================================
# NETWORKING
# =====================================

variable "subnet_id" {

  description = "AKS subnet ID"

  type = string
}

variable "service_cidr" {

  description = "AKS service CIDR"

  type = string
}

variable "dns_service_ip" {

  description = "AKS DNS service IP"

  type = string
}

# =====================================
# MONITORING
# =====================================

variable "enable_monitoring" {

  description = "Enable Azure Monitor"

  type = bool

  default = true
}

variable "log_analytics_workspace_id" {

  description = "Log Analytics Workspace ID"

  type = string

  default = null
}

variable "azure_monitor_workspace_id" {

  description = "Azure Monitor Workspace ID"

  type = string

  default = null
}

# =====================================
# KEY VAULT CSI DRIVER
# =====================================

variable "enable_key_vault_secrets_provider" {

  description = "Enable Azure Key Vault CSI Driver"

  type = bool

  default = true
}

variable "secret_rotation_enabled" {

  description = "Enable Key Vault secret rotation"

  type = bool

  default = true
}

# =====================================
# IMAGE CLEANER
# =====================================

variable "enable_image_cleaner" {

  description = "Enable AKS image cleaner"

  type = bool

  default = false
}

variable "image_cleaner_interval_hours" {

  description = "AKS image cleaner interval"

  type = number

  default = 48
}

# =====================================
# NODE LABELS / TAINTS
# =====================================

variable "node_labels" {

  description = "AKS node labels"

  type = map(string)

  default = {}
}

variable "node_taints" {

  description = "AKS node taints"

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

  description = "Enable AKS spot node pool"

  type = bool

  default = false
}

variable "spot_node_pool_name" {

  description = "Spot node pool name"

  type = string

  default = "spotpool"
}

variable "spot_node_vm_size" {

  description = "Spot node VM size"

  type = string

  default = "Standard_D2s_v3"
}

variable "spot_max_price" {

  description = "Maximum spot node price"

  type = number

  default = -1
}

variable "spot_node_min_count" {

  description = "Minimum spot node count"

  type = number

  default = 0
}

variable "spot_node_max_count" {

  description = "Maximum spot node count"

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
# ACR INTEGRATION
# =====================================

variable "enable_acr_pull_role_assignment" {

  description = "Enable AcrPull role assignment"

  type = bool

  default = true
}

variable "acr_id" {

  description = "Azure Container Registry ID"

  type = string

  default = null
}