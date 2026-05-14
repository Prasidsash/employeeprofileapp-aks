# =====================================
# ENVIRONMENT
# =====================================

environment         = "dev"
resource_group_name = "employeeprofileapp-dev-rg"
location            = "Central India"

# =====================================
# NETWORK INFRASTRUCTURE
# =====================================

vnet_name = "employeeprofileapp-dev-vnet"

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

cluster_name        = "employeeprofileapp-dev-aks"
kubernetes_version  = "1.34.6"

system_node_count   = 1
system_node_vm_size = "Standard_D2s_v3"

service_cidr        = "172.16.0.0/16"
dns_service_ip      = "172.16.0.10"

enable_node_autoscaling = false

system_node_min_count = 1
system_node_max_count = 2

# =====================================
# MONITORING
# =====================================

log_analytics_workspace_name = "employeeprofileapp-dev-law"
log_analytics_sku            = "PerGB2018"
log_retention_in_days        = 30

# =====================================
# KUBERNETES NAMESPACE
# =====================================

namespace_name = "employeeprofileapp-dev"

namespace_labels = {

  environment = "dev"
  app         = "employeeprofileapp"
}

# =====================================
# GOVERNANCE
# =====================================

quota_limits = {

  pods              = "10"
  "requests.cpu"    = "2"
  "requests.memory" = "2Gi"
  "limits.cpu"      = "4"
  "limits.memory"   = "4Gi"
}

limit_max = {

  cpu    = "1"
  memory = "1Gi"
}

limit_min = {

  cpu    = "100m"
  memory = "128Mi"
}

limit_default = {

  cpu    = "500m"
  memory = "512Mi"
}

limit_default_request = {

  cpu    = "250m"
  memory = "256Mi"
}

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
# SECRETS
# =====================================

secret_name = "employee-db-secret"

# =====================================
# INGRESS
# =====================================

ingress_name      = "employee-ingress"
ingress_host      = "dev.employee.local"
ingress_path      = "/"
ingress_path_type = "Prefix"

service_name = "employeeprofileapp-service-dev"

# =====================================
# TLS / HTTPS
# =====================================

enable_tls      = false
tls_secret_name = null

# =====================================
# HELM
# =====================================

release_name = "employeeprofileapp-dev"

# =====================================
# PLATFORM FEATURE TOGGLES
# =====================================

enable_alerts               = false
enable_managed_prometheus   = false
enable_hpa                  = false
enable_loadbalancer         = false

# =====================================
# MODULE TOGGLES
# Core infrastructure (normally leave enabled)
# =====================================

enable_aks         = true
enable_network     = true
enable_monitoring  = true
enable_namespace   = true
enable_rbac        = true
enable_governance  = true
enable_secret      = true
enable_ingress     = true