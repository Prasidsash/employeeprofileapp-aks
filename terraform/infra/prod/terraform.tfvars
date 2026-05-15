# =====================================
# ENVIRONMENT
# =====================================

environment = "prod"

resource_group_name = "employeeprofileapp-prod-rg"

location = "Central India"

# =====================================
# NETWORK
# =====================================

vnet_name = "employeeprofileapp-prod-vnet"

vnet_address_space = [
  "10.10.0.0/16"
]

aks_subnet_name = "aks-subnet"

aks_subnet_prefixes = [
  "10.10.1.0/24"
]

# =====================================
# AKS CLUSTER
# =====================================

cluster_name = "employeeprofileapp-prod-aks"

kubernetes_version = "1.34.6"

system_node_count = 1

system_node_vm_size = "Standard_D2s_v3"

# =====================================
# AKS NETWORKING
# =====================================

service_cidr = "172.16.0.0/16"

dns_service_ip = "172.16.0.10"

# =====================================
# AKS NODE AUTOSCALING
# =====================================

enable_node_autoscaling = false

system_node_min_count = 1

system_node_max_count = 2

# =====================================
# OPTIONAL FUTURE AKS FEATURES
# Preserve Existing Runtime Behavior
# =====================================

enable_workload_identity = false

enable_oidc_issuer = true

enable_image_cleaner = false

image_cleaner_interval_hours = 48

node_labels = {}

node_taints = []

enable_api_server_access_profile = false

authorized_ip_ranges = []

aks_additional_tags = {}

# =====================================
# MONITORING
# LOW-COST SINGLE NODE OPTIMIZATION
# =====================================

log_analytics_workspace_name = "employeeprofileapp-prod-law"

log_analytics_sku = "PerGB2018"

log_retention_in_days = 30

enable_alerts = false

enable_managed_prometheus = false

# =====================================
# OPTIONAL MONITORING SETTINGS
# =====================================

grafana_major_version = 11

grafana_api_key_enabled = true

monitoring_additional_tags = {}

# =====================================
# KUBERNETES NAMESPACE
# =====================================

namespace_name = "employeeprofileapp-prod"

namespace_labels = {

  environment = "prod"

  app = "employeeprofileapp"
}

# =====================================
# OPTIONAL NAMESPACE ANNOTATIONS
# =====================================

namespace_annotations = {}

# =====================================
# GOVERNANCE
# LOW-COST PROD SAFE LIMITS
# =====================================

quota_limits = {

  pods = "10"

  "requests.cpu" = "2"

  "requests.memory" = "2Gi"

  "limits.cpu" = "4"

  "limits.memory" = "4Gi"
}

limit_max = {

  cpu = "1"

  memory = "1Gi"
}

limit_min = {

  cpu = "50m"

  memory = "64Mi"
}

limit_default = {

  cpu = "150m"

  memory = "256Mi"
}

limit_default_request = {

  cpu = "50m"

  memory = "64Mi"
}

# =====================================
# OPTIONAL GOVERNANCE METADATA
# =====================================

governance_labels = {}

governance_annotations = {}

# =====================================
# RBAC
# =====================================

service_account_name = "employee-sa"

role_name = "employee-role"

allowed_resources = [

  "pods",
  "services",
  "secrets",
  "configmaps"
]

allowed_verbs = [

  "get",
  "list",
  "watch"
]

# =====================================
# OPTIONAL RBAC METADATA
# =====================================

service_account_annotations = {}

role_annotations = {}

role_binding_annotations = {}

rbac_additional_labels = {}

rbac_additional_annotations = {}

# =====================================
# SECRETS
# =====================================

secret_name = "employee-db-secret"

secret_data = {}

# =====================================
# OPTIONAL SECRET SETTINGS
# =====================================

secret_annotations = {}

secret_type = "Opaque"

secret_immutable = false

secret_additional_labels = {}

secret_additional_annotations = {}

# =====================================
# KEY VAULT RBAC STABILIZATION
# =====================================

keyvault_admin_object_id = "b77f8b73-2b9a-43e9-8ce6-10546c8c328a"

# =====================================
# OPTIONAL KEY VAULT FEATURES
# =====================================

enable_network_acls = false

keyvault_additional_tags = {}

# =====================================
# INGRESS
# =====================================

ingress_name = "employee-ingress"

ingress_host = "prod.employee.local"

ingress_path = "/"

ingress_path_type = "Prefix"

service_name = "employeeprofileapp-service-prod"

# =====================================
# OPTIONAL INGRESS FEATURES
# =====================================

ingress_class_name = "nginx"

enable_rewrite_target = false

enable_proxy_body_size = false

proxy_body_size = "10m"

cluster_issuer = null

# =====================================
# TLS / HTTPS
# =====================================

enable_tls = false

tls_secret_name = null

# =====================================
# HELM
# =====================================

release_name = "employeeprofileapp-prod"

# =====================================
# PLATFORM FEATURES
# =====================================

enable_hpa = false

enable_loadbalancer = false

# =====================================
# MODULE TOGGLES
# =====================================

enable_aks = true

enable_network = true

enable_monitoring = true

enable_namespace = true

enable_rbac = true

enable_governance = true

enable_secret = true

enable_ingress = true