# =====================================
# ENVIRONMENT
# =====================================

environment = "prod"

resource_group_name = "employeeprofileapp-prod-rg"

location = "Central India"

# =====================================
# NETWORK
# =====================================

enable_network = true

vnet_name = "employeeprofileapp-prod-vnet"

vnet_address_space = [
  "10.10.0.0/16"
]

aks_subnet_name = "aks-subnet"

aks_subnet_prefixes = [
  "10.10.1.0/24"
]

service_cidr = "172.16.0.0/16"

dns_service_ip = "172.16.0.10"

# =====================================
# AKS CLUSTER
# =====================================

enable_aks = true

cluster_name = "employeeprofileapp-prod-aks"

kubernetes_version = "1.34.6"

# =====================================
# SYSTEM NODE POOL
# =====================================

enable_node_autoscaling = true

only_critical_addons_enabled = false

system_node_count = 1

#system_node_vm_size = "Standard_D2s_v5"
system_node_vm_size = "Standard_B2s"

system_node_min_count = 1

system_node_max_count = 2

node_labels = {}

node_taints = []

# =====================================
# SPOT NODE POOL
# =====================================

enable_spot_node_pool = false

spot_node_pool_name = "spotpool"

spot_node_vm_size = "Standard_D2s_v5"

spot_max_price = -1

spot_node_min_count = 1

spot_node_max_count = 2

spot_node_labels = {

  workload = "spot"

  "kubernetes.azure.com/scalesetpriority" = "spot"
}

spot_node_taints = [

  "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
]

# =====================================
# OPTIONAL AKS FEATURES
# =====================================

enable_workload_identity = true

enable_oidc_issuer = true

enable_image_cleaner = false

enable_api_server_access_profile = false

image_cleaner_interval_hours = 48

authorized_ip_ranges = []

aks_additional_tags = {}

# =====================================
# OPTIONAL KEY VAULT CSI DRIVER
# =====================================

enable_key_vault_secrets_provider = true

secret_rotation_enabled = true

# =====================================
# OPTIONAL USER ASSIGNED IDENTITY
# =====================================

enable_user_assigned_identity = false

user_assigned_identity_ids = []

# =====================================
# MONITORING
# =====================================

enable_monitoring = false

enable_alerts = false

enable_managed_prometheus = false

log_analytics_workspace_name = "employeeprofileapp-prod-law"

log_analytics_sku = "PerGB2018"

log_retention_in_days = 30

grafana_major_version = 11

grafana_api_key_enabled = false

monitoring_additional_tags = {}

# =====================================
# NAMESPACE
# =====================================

enable_namespace = true

namespace_name = "employeeprofileapp-prod"

namespace_labels = {

  environment = "prod"

  app = "employeeprofileapp"
}

namespace_annotations = {}

# =====================================
# GOVERNANCE
# =====================================

enable_governance = true

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

governance_labels = {}

governance_annotations = {}

# =====================================
# POD DISRUPTION BUDGET
# =====================================

enable_pod_disruption_budget = false

pod_disruption_budget_name = "employeeprofileapp-prod-pdb"

pdb_max_unavailable = "1"

pdb_match_labels = {
  app = "employeeprofileapp"
}

pod_disruption_budget_annotations = {}

# =====================================
# RBAC
# =====================================

enable_rbac = true

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

service_account_annotations = {}

role_annotations = {}

role_binding_annotations = {}

rbac_additional_labels = {}

rbac_additional_annotations = {}

# =====================================
# WORKLOAD IDENTITY
# =====================================

enable_workload_identity_resources = true

# =====================================
# SECRETS
# =====================================

enable_secret = false

secret_name = "employee-db-secret"

secret_data = {}

secret_annotations = {}

secret_type = "Opaque"

secret_immutable = false

secret_additional_labels = {}

secret_additional_annotations = {}

# =====================================
# KEY VAULT
# =====================================

enable_network_acls = true

keyvault_admin_object_id = "b77f8b73-2b9a-43e9-8ce6-10546c8c328a"

keyvault_additional_tags = {}

# =====================================
# INGRESS CONTROLLER
# =====================================

enable_ingress_controller = true

ingress_controller_namespace = "ingress-nginx"

ingress_controller_chart_version = "4.12.2"

ingress_controller_service_type = "LoadBalancer"

ingress_controller_replica_count = 1

# =====================================
# INGRESS
# =====================================

enable_ingress = true

enable_rewrite_target = false

enable_proxy_body_size = false

ingress_name = "employee-ingress"

ingress_host = "prod.employee.local"

ingress_path = "/"

ingress_path_type = "Prefix"

service_name = "employeeprofileapp-service-prod"

ingress_class_name = "nginx"

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

release_name = "employeeprofileapp-prod-release"

# =====================================
# PLATFORM FEATURES
# =====================================

enable_loadbalancer = true

enable_hpa = false

# =====================================
# AKS BACKUP
# =====================================

enable_aks_backup = false

backup_vault_name = "employeeprofileapp-prod-backup-vault"

backup_storage_account_name = "empprofprodbackup2026"

backup_container_name = "aks-backups"

backup_policy_name = "employeeprofileapp-prod-backup-policy"

backup_schedule_repeating_time_intervals = [
  "R/2026-01-01T02:00:00+00:00/PT24H"
]

backup_retention_duration_count = 30

backup_retention_duration_type = "D"

backup_additional_tags = {}

# =====================================
# CERT MANAGER
# =====================================

enable_cert_manager = true

cert_manager_namespace = "cert-manager"

cert_manager_chart_version = "v1.18.2"

enable_cluster_issuer = true

cluster_issuer_name = "selfsigned-cluster-issuer"