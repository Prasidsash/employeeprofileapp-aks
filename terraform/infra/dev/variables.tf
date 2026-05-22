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
# OPTIONAL FUTURE AKS FEATURES
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

  description = "AKS Backup Vault Name"

  type = string
}

variable "backup_storage_account_name" {

  description = "AKS Backup Storage Account Name"

  type = string
}

variable "backup_container_name" {

  description = "AKS Backup Storage Container Name"

  type = string
}

variable "backup_policy_name" {

  description = "AKS Backup Policy Name"

  type = string
}

variable "backup_schedule_repeating_time_intervals" {

  description = "AKS Backup Schedule Intervals"

  type = list(string)
}

variable "backup_retention_duration_count" {

  description = "AKS Backup Retention Count"

  type = number
}

variable "backup_retention_duration_type" {

  description = "AKS Backup Retention Duration Type"

  type = string
}

variable "backup_additional_tags" {

  description = "Additional AKS Backup Tags"

  type = map(string)

  default = {}
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
# OPTIONAL NAMESPACE ANNOTATIONS
# =====================================

variable "namespace_annotations" {

  description = "Optional namespace annotations"

  type = map(string)

  default = {}
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
# OPTIONAL GOVERNANCE METADATA
# =====================================

variable "governance_labels" {

  description = "Optional governance labels"

  type = map(string)

  default = {}
}

variable "governance_annotations" {

  description = "Optional governance annotations"

  type = map(string)

  default = {}
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
# OPTIONAL RBAC ANNOTATIONS
# =====================================

variable "service_account_annotations" {

  description = "Optional ServiceAccount annotations"

  type = map(string)

  default = {}
}

variable "role_annotations" {

  description = "Optional Role annotations"

  type = map(string)

  default = {}
}

variable "role_binding_annotations" {

  description = "Optional RoleBinding annotations"

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
# SECRET
# =====================================

variable "secret_name" {
  type = string
}

variable "secret_data" {

  type = map(string)

  sensitive = true

  default = {}
}

# =====================================
# OPTIONAL SECRET SETTINGS
# =====================================

variable "secret_annotations" {

  description = "Optional Kubernetes Secret annotations"

  type = map(string)

  default = {}
}

variable "secret_type" {

  description = "Kubernetes Secret type"

  type = string

  default = "Opaque"
}

variable "secret_immutable" {

  description = "Immutable Kubernetes Secret"

  type = bool

  default = false
}

variable "secret_additional_labels" {

  description = "Additional Secret labels"

  type = map(string)

  default = {}
}

variable "secret_additional_annotations" {

  description = "Additional Secret annotations"

  type = map(string)

  default = {}
}

# =====================================
# KEY VAULT RBAC
# =====================================

variable "keyvault_admin_object_id" {

  description = "Stable Object ID for Key Vault Administrator RBAC assignment"

  type = string
}

# =====================================
# OPTIONAL KEY VAULT FEATURES
# =====================================

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
# OPTIONAL INGRESS FEATURES
# =====================================

variable "ingress_class_name" {

  description = "Ingress Controller Class Name"

  type = string

  default = "nginx"
}

variable "enable_rewrite_target" {

  description = "Enable ingress rewrite-target annotation"

  type = bool

  default = false
}

variable "enable_proxy_body_size" {

  description = "Enable ingress proxy-body-size annotation"

  type = bool

  default = false
}

variable "proxy_body_size" {

  description = "Ingress proxy body size"

  type = string

  default = "10m"
}

variable "cluster_issuer" {

  description = "Optional cert-manager ClusterIssuer"

  type = string

  default = null
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

variable "grafana_major_version" {

  description = "Azure Managed Grafana version"

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

  default = "Standard_B2s"
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
# AKS BACKUP FEATURE TOGGLE
# =====================================

variable "enable_aks_backup" {

  description = "Enable AKS Backup Module"

  type = bool

  default = false
}

# =====================================
# INGRESS NGINX CONTROLLER
# =====================================

variable "enable_ingress_controller" {

  description = "Enable NGINX ingress controller"

  type = bool

  default = false
}

variable "ingress_controller_namespace" {

  description = "Ingress controller namespace"

  type = string

  default = "ingress-nginx"
}

variable "ingress_controller_chart_version" {

  description = "Ingress NGINX chart version"

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

  description = "cert-manager Helm chart version"

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

  description = "Enable or disable Pod Disruption Budget"

  type = bool

  default = false
}

variable "pod_disruption_budget_name" {

  description = "Pod Disruption Budget name"

  type = string

  default = "employeeprofileapp-pdb"
}

variable "pdb_max_unavailable" {

  description = "Maximum unavailable pods during voluntary disruptions"

  type = string

  default = "1"
}

variable "pdb_match_labels" {

  description = "Labels used for Pod Disruption Budget selector"

  type = map(string)

  default = {
    app = "employeeprofileapp"
  }
}

variable "pod_disruption_budget_annotations" {

  description = "Annotations for Pod Disruption Budget"

  type = map(string)

  default = {}
}