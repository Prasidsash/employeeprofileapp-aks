# =====================================
# COMMON
# =====================================

variable "environment" {

  description = "Environment name"

  type = string
}

variable "resource_group_name" {

  description = "Azure Resource Group name"

  type = string
}

variable "location" {

  description = "Azure region"

  type = string
}

# =====================================
# NETWORK
# =====================================

variable "vnet_name" {

  description = "Virtual Network name"

  type = string
}

variable "vnet_address_space" {

  description = "Virtual Network address space"

  type = list(string)
}

variable "aks_subnet_name" {

  description = "AKS subnet name"

  type = string
}

variable "aks_subnet_prefixes" {

  description = "AKS subnet prefixes"

  type = list(string)
}

# =====================================
# AKS
# =====================================

variable "cluster_name" {

  description = "AKS cluster name"

  type = string
}

variable "kubernetes_version" {

  description = "AKS Kubernetes version"

  type = string
}

variable "system_node_count" {

  description = "System node count"

  type = number
}

variable "system_node_vm_size" {

  description = "System node VM size"

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
# AKS AUTOSCALING
# =====================================

variable "enable_node_autoscaling" {

  description = "Enable AKS node autoscaling"

  type = bool
}

variable "only_critical_addons_enabled" {

  description = "Allow only critical addons on system node pool"

  type = bool

  default = false
}

variable "system_node_min_count" {

  description = "Minimum system node count"

  type = number
}

variable "system_node_max_count" {

  description = "Maximum system node count"

  type = number
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

  description = "Enable Azure Key Vault secret rotation"

  type = bool

  default = true
}

# =====================================
# AKS IMAGE CLEANER
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

  description = "Authorized IP ranges for AKS API server"

  type = list(string)

  default = []
}

variable "aks_additional_tags" {

  description = "Additional AKS tags"

  type = map(string)

  default = {}
}

# =====================================
# AKS BACKUP
# =====================================

variable "backup_vault_name" {

  description = "Backup vault name"

  type = string
}

variable "backup_storage_account_name" {

  description = "Backup storage account name"

  type = string
}

variable "backup_container_name" {

  description = "Backup container name"

  type = string
}

variable "backup_policy_name" {

  description = "Backup policy name"

  type = string
}

variable "backup_schedule_repeating_time_intervals" {

  description = "Backup schedule intervals"

  type = list(string)
}

variable "backup_retention_duration_count" {

  description = "Backup retention count"

  type = number
}

variable "backup_retention_duration_type" {

  description = "Backup retention duration type"

  type = string
}

variable "backup_additional_tags" {

  description = "Additional backup tags"

  type = map(string)

  default = {}
}

# =====================================
# NAMESPACE
# =====================================

variable "namespace_name" {

  description = "Kubernetes namespace"

  type = string
}

variable "namespace_labels" {

  description = "Namespace labels"

  type = map(string)
}

variable "namespace_annotations" {

  description = "Namespace annotations"

  type = map(string)

  default = {}
}

# =====================================
# GOVERNANCE
# =====================================

variable "quota_limits" {

  description = "Resource quota limits"

  type = map(string)
}

variable "limit_max" {

  description = "Limit range max"

  type = map(string)
}

variable "limit_min" {

  description = "Limit range min"

  type = map(string)
}

variable "limit_default" {

  description = "Limit range default"

  type = map(string)
}

variable "limit_default_request" {

  description = "Limit range default request"

  type = map(string)
}

variable "governance_labels" {

  description = "Governance labels"

  type = map(string)

  default = {}
}

variable "governance_annotations" {

  description = "Governance annotations"

  type = map(string)

  default = {}
}

# =====================================
# RBAC
# =====================================

variable "service_account_name" {

  description = "Kubernetes service account"

  type = string
}

variable "role_name" {

  description = "Kubernetes RBAC role"

  type = string
}

variable "allowed_resources" {

  description = "Allowed Kubernetes resources"

  type = list(string)
}

variable "allowed_verbs" {

  description = "Allowed Kubernetes verbs"

  type = list(string)
}

variable "service_account_annotations" {

  description = "ServiceAccount annotations"

  type = map(string)

  default = {}
}

variable "role_annotations" {

  description = "Role annotations"

  type = map(string)

  default = {}
}

variable "role_binding_annotations" {

  description = "RoleBinding annotations"

  type = map(string)

  default = {}
}

variable "rbac_additional_labels" {

  description = "Additional RBAC labels"

  type = map(string)

  default = {}
}

variable "rbac_additional_annotations" {

  description = "Additional RBAC annotations"

  type = map(string)

  default = {}
}

# =====================================
# KEY VAULT
# =====================================

variable "keyvault_admin_object_id" {

  description = "Key Vault Administrator object ID"

  type = string
}

variable "enable_aks_kv_rbac" {

  description = "Enable AKS Key Vault CSI RBAC"

  type = bool

  default = true
}

variable "enable_network_acls" {

  description = "Enable Key Vault network ACLs"

  type = bool

  default = false
}

variable "keyvault_additional_tags" {

  description = "Additional Key Vault tags"

  type = map(string)

  default = {}
}

variable "enable_default_key_vault_secrets" {

  description = "Enable default Key Vault secrets"

  type = bool

  default = true
}

# =====================================
# DATABASE SECRETS
# =====================================

variable "db_username" {

  description = "Database username"

  type = string

  sensitive = true
}

variable "db_password" {

  description = "Database password"

  type = string

  sensitive = true
}

# =====================================
# INGRESS
# =====================================

variable "ingress_name" {

  description = "Ingress name"

  type = string
}

variable "ingress_host" {

  description = "Ingress hostname"

  type = string
}

variable "ingress_path" {

  description = "Ingress path"

  type = string
}

variable "ingress_path_type" {

  description = "Ingress path type"

  type = string
}

variable "service_name" {

  description = "Kubernetes service name"

  type = string
}

variable "ingress_class_name" {

  description = "Ingress class name"

  type = string

  default = "nginx"
}

variable "enable_rewrite_target" {

  description = "Enable ingress rewrite-target"

  type = bool

  default = false
}

variable "enable_proxy_body_size" {

  description = "Enable ingress proxy-body-size"

  type = bool

  default = false
}

variable "proxy_body_size" {

  description = "Ingress proxy body size"

  type = string

  default = "10m"
}

variable "cluster_issuer" {

  description = "cert-manager ClusterIssuer"

  type = string

  default = null
}

# =====================================
# TLS / HTTPS
# =====================================

variable "enable_tls" {

  description = "Enable TLS ingress"

  type = bool

  default = false
}

variable "tls_secret_name" {

  description = "TLS secret name"

  type = string

  default = null
}

# =====================================
# HELM
# =====================================

variable "release_name" {

  description = "Helm release name"

  type = string
}

# =====================================
# MONITORING
# =====================================

variable "log_analytics_workspace_name" {

  description = "Log Analytics workspace name"

  type = string
}

variable "log_analytics_sku" {

  description = "Log Analytics SKU"

  type = string
}

variable "log_retention_in_days" {

  description = "Log retention days"

  type = number
}

variable "enable_alerts" {

  description = "Enable Azure Monitor alerts"

  type = bool

  default = false
}

variable "enable_managed_prometheus" {

  description = "Enable managed Prometheus"

  type = bool

  default = false
}

variable "grafana_major_version" {

  description = "Grafana major version"

  type = number

  default = 11
}

variable "grafana_api_key_enabled" {

  description = "Enable Grafana API keys"

  type = bool

  default = true
}

variable "monitoring_additional_tags" {

  description = "Additional monitoring tags"

  type = map(string)

  default = {}
}

# =====================================
# FEATURE TOGGLES
# =====================================

variable "enable_network" {

  description = "Enable network module"

  type = bool
}

variable "enable_aks" {

  description = "Enable AKS module"

  type = bool
}

variable "enable_namespace" {

  description = "Enable namespace module"

  type = bool
}

variable "enable_rbac" {

  description = "Enable RBAC module"

  type = bool
}

variable "enable_governance" {

  description = "Enable governance module"

  type = bool
}

variable "enable_ingress" {

  description = "Enable ingress module"

  type = bool
}

variable "enable_monitoring" {

  description = "Enable monitoring"

  type = bool

  default = true
}

variable "enable_hpa" {

  description = "Enable Horizontal Pod Autoscaler"

  type = bool

  default = true
}

variable "enable_loadbalancer" {

  description = "Enable LoadBalancer"

  type = bool

  default = true
}

# =====================================
# SPOT NODE POOL
# =====================================

variable "enable_spot_node_pool" {

  description = "Enable spot node pool"

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

  default = "Standard_B2s"
}

variable "spot_max_price" {

  description = "Spot max price"

  type = number

  default = -1
}

variable "spot_node_min_count" {

  description = "Spot minimum node count"

  type = number

  default = 0
}

variable "spot_node_max_count" {

  description = "Spot maximum node count"

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
# AKS BACKUP FEATURE TOGGLE
# =====================================

variable "enable_aks_backup" {

  description = "Enable AKS backup"

  type = bool

  default = false
}

# =====================================
# INGRESS CONTROLLER
# =====================================

variable "enable_ingress_controller" {

  description = "Enable ingress controller"

  type = bool

  default = true
}

variable "ingress_controller_namespace" {

  description = "Ingress controller namespace"

  type = string

  default = "ingress-nginx"
}

variable "ingress_controller_chart_version" {

  description = "Ingress controller chart version"

  type = string

  default = "4.12.2"
}

variable "ingress_controller_service_type" {

  description = "Ingress controller service type"

  type = string

  default = "LoadBalancer"
}

variable "ingress_controller_replica_count" {

  description = "Ingress controller replica count"

  type = number

  default = 1
}

# =====================================
# CERT MANAGER
# =====================================

variable "enable_cert_manager" {

  description = "Enable cert-manager"

  type = bool

  default = false
}

variable "cert_manager_namespace" {

  description = "cert-manager namespace"

  type = string

  default = "cert-manager"
}

variable "cert_manager_chart_version" {

  description = "cert-manager chart version"

  type = string

  default = "v1.18.2"
}

variable "enable_cluster_issuer" {

  description = "Enable ClusterIssuer"

  type = bool

  default = false
}

variable "cluster_issuer_name" {

  description = "ClusterIssuer name"

  type = string

  default = "selfsigned-cluster-issuer"
}

# =====================================
# POD DISRUPTION BUDGET
# =====================================

variable "enable_pod_disruption_budget" {

  description = "Enable Pod Disruption Budget"

  type = bool

  default = false
}

variable "pod_disruption_budget_name" {

  description = "Pod Disruption Budget name"

  type = string

  default = "employeeprofileapp-pdb"
}

variable "pdb_max_unavailable" {

  description = "Maximum unavailable pods"

  type = string

  default = "1"
}

variable "pdb_match_labels" {

  description = "PDB selector labels"

  type = map(string)

  default = {
    app = "employeeprofileapp"
  }
}

variable "pod_disruption_budget_annotations" {

  description = "PDB annotations"

  type = map(string)

  default = {}
}

# =====================================
# ACR
# =====================================

variable "enable_acr" {

  description = "Enable Azure Container Registry"

  type = bool

  default = true
}

variable "acr_name" {

  description = "Azure Container Registry name"

  type = string
}

variable "acr_sku" {

  description = "Azure Container Registry SKU"

  type = string

  default = "Basic"
}