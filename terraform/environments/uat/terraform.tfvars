environment = "uat"

resource_group_name = "employeeprofileapp-uat-rg"

location = "Central India"

# ---------------------
# Namespace
# ---------------------

namespace_name = "employeeprofileapp-uat"

namespace_labels = {
  environment = "uat"
  app         = "employeeprofileapp"
}

# ---------------------
# Governance
# ---------------------

quota_limits = {
  pods              = "30"
  "requests.cpu"    = "6"
  "requests.memory" = "6Gi"
  "limits.cpu"      = "12"
  "limits.memory"   = "12Gi"
}

# ---------------------
# LimitRange
# ---------------------

limit_max = {
  cpu    = "3"
  memory = "4Gi"
}

limit_min = {
  cpu    = "100m"
  memory = "256Mi"
}

limit_default = {
  cpu    = "500m"
  memory = "512Mi"
}

limit_default_request = {
  cpu    = "250m"
  memory = "256Mi"
}

# ---------------------
# RBAC
# ---------------------

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

# ---------------------
# Secret
# ---------------------

secret_name = "employee-db-secret"

# ---------------------
# Ingress
# ---------------------

ingress_name = "employee-ingress"

ingress_host = "uat.employee.local"

ingress_path = "/"

ingress_path_type = "Prefix"

service_name = "employeeprofileapp-uat"

# ---------------------
# Helm
# ---------------------

release_name = "employeeprofileapp-uat"

# ---------------------
# Network
# ---------------------

vnet_name = "employeeprofileapp-uat-vnet"

vnet_address_space = [
  "10.30.0.0/16"
]

aks_subnet_name = "aks-subnet"

aks_subnet_prefixes = [
  "10.30.1.0/24"
]

# ---------------------
# Monitoring
# ---------------------

log_analytics_workspace_name = "employeeprofileapp-uat-law"

log_analytics_sku = "PerGB2018"

log_retention_in_days = 30

# ---------------------
# AKS
# ---------------------

cluster_name = "employeeprofileapp-uat-aks"

kubernetes_version = "1.34.6"

system_node_count = 1

system_node_vm_size = "Standard_D2s_v3"

# ---------------------
# AKS Networking
# ---------------------

service_cidr = "172.30.0.0/16"

dns_service_ip = "172.30.0.10"

# =====================================
# Module Toggles
# =====================================

enable_network = true

enable_aks = true

enable_namespace = true

enable_rbac = true

enable_governance = true

enable_secret = true

enable_ingress = true

enable_monitoring = true