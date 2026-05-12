environment = "qa"

resource_group_name = "employeeprofileapp-qa-rg"

location = "Central India"

# ---------------------
# Namespace
# ---------------------

namespace_name = "employeeprofileapp-qa"

namespace_labels = {
  environment = "qa"
  app         = "employeeprofileapp"
}

# ---------------------
# Governance
# ---------------------

quota_limits = {
  pods              = "10"
  "requests.cpu"    = "2"
  "requests.memory" = "2Gi"
  "limits.cpu"      = "4"
  "limits.memory"   = "4Gi"
}

# ---------------------
# LimitRange
# ---------------------

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

ingress_host = "qa.employee.local"

ingress_path = "/"

ingress_path_type = "Prefix"

service_name = "employeeprofileapp-qa"

# ---------------------
# Helm
# ---------------------

release_name = "employeeprofileapp-qa"

# ---------------------
# Network
# ---------------------

vnet_name = "employeeprofileapp-qa-vnet"

vnet_address_space = [
  "10.10.0.0/16"
]

aks_subnet_name = "aks-subnet"

aks_subnet_prefixes = [
  "10.10.1.0/24"
]

# ---------------------
# Monitoring
# ---------------------
# Required only when:
# enable_monitoring = true
# Currently monitoring is disabled,
# but values are added for future readiness.

log_analytics_workspace_name = "employeeprofileapp-qa-law"

log_analytics_sku = "PerGB2018"

log_retention_in_days = 30

# ---------------------
# AKS
# ---------------------

cluster_name = "employeeprofileapp-qa-aks"

kubernetes_version = "1.34.6"

system_node_count = 1

system_node_vm_size = "Standard_D2s_v3"

# ---------------------
# AKS Networking
# ---------------------

service_cidr = "172.16.0.0/16"

dns_service_ip = "172.16.0.10"

# =====================================
# Module Toggles
# =====================================

enable_aks = true

enable_network = true

enable_monitoring = true

enable_namespace = false

enable_rbac = false

enable_governance = false

enable_secret = false

enable_ingress = false