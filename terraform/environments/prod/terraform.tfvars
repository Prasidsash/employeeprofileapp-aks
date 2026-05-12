environment = "prod"

resource_group_name = "employeeprofileapp-prod-rg"

location = "Central India"

# ---------------------
# Namespace
# ---------------------

namespace_name = "employeeprofileapp-prod"

namespace_labels = {
  environment = "prod"
  app         = "employeeprofileapp"
}

# ---------------------
# Governance
# ---------------------

quota_limits = {
  pods              = "20"
  "requests.cpu"    = "4"
  "requests.memory" = "4Gi"
  "limits.cpu"      = "8"
  "limits.memory"   = "8Gi"
}

# ---------------------
# LimitRange
# ---------------------

limit_max = {
  cpu    = "2"
  memory = "2Gi"
}

limit_min = {
  cpu    = "200m"
  memory = "256Mi"
}

limit_default = {
  cpu    = "1"
  memory = "1Gi"
}

limit_default_request = {
  cpu    = "500m"
  memory = "512Mi"
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

ingress_host = "employee.company.com"

ingress_path = "/"

ingress_path_type = "Prefix"

service_name = "employeeprofileapp-prod"

# ---------------------
# Helm
# ---------------------

release_name = "employeeprofileapp-prod"

# ---------------------
# Network
# ---------------------

vnet_name = "employeeprofileapp-prod-vnet"

vnet_address_space = [
  "10.40.0.0/16"
]

aks_subnet_name = "aks-subnet"

aks_subnet_prefixes = [
  "10.40.1.0/24"
]

# ---------------------
# Monitoring
# ---------------------

log_analytics_workspace_name = "employeeprofileapp-prod-law"

log_analytics_sku = "PerGB2018"

log_retention_in_days = 90

# ---------------------
# AKS
# ---------------------

cluster_name = "employeeprofileapp-prod-aks"

kubernetes_version = "1.34.6"

system_node_count = 2

system_node_vm_size = "Standard_D4s_v3"

# ---------------------
# AKS Networking
# ---------------------

service_cidr = "172.19.0.0/16"

dns_service_ip = "172.19.0.10"

# ---------------------
# Module Toggles
# ---------------------

enable_network = true

enable_aks = true

enable_namespace = true

enable_rbac = true

enable_governance = true

enable_secret = true

enable_ingress = true

enable_monitoring = true