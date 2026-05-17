# =====================================
# RESOURCE GROUP
# =====================================

resource "azurerm_resource_group" "main" {

  name = var.resource_group_name

  location = var.location

  tags = {

    environment = var.environment

    project = "employeeprofileapp"

    managed_by = "terraform"
  }
}

# =====================================
# NETWORK MODULE
# =====================================

module "network" {

  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  vnet_name = var.vnet_name

  vnet_address_space = var.vnet_address_space

  aks_subnet_name = var.aks_subnet_name

  aks_subnet_prefixes = var.aks_subnet_prefixes

  environment = var.environment
}

# =====================================
# MONITORING MODULE
# DO NOT MODIFY OUTPUT BEHAVIOR
# =====================================

module "monitoring" {

  source = "../../modules/monitoring"

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  log_analytics_workspace_name = var.log_analytics_workspace_name

  log_analytics_sku = var.log_analytics_sku

  log_retention_in_days = var.log_retention_in_days

  environment = var.environment

  enable_alerts = var.enable_alerts

  enable_managed_prometheus = var.enable_managed_prometheus

  aks_cluster_id = null

  # =====================================
  # OPTIONAL TAGS
  # =====================================

  additional_tags = {}
}

# =====================================
# KEY VAULT MODULE
# =====================================

module "keyvault" {

  source = "../../modules/keyvault"

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  environment = var.environment

  # =====================================
  # Stable Key Vault RBAC Principal
  # Prevents RBAC Replacement Drift
  # =====================================

  keyvault_admin_object_id = var.keyvault_admin_object_id

  # =====================================
  # OPTIONAL FEATURES
  # =====================================

  enable_network_acls = false

  additional_tags = {}

  depends_on = [
    azurerm_resource_group.main
  ]
}

# =====================================
# AKS MODULE
# =====================================

module "aks" {

  source = "../../modules/aks"

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  cluster_name = var.cluster_name

  kubernetes_version = var.kubernetes_version

  system_node_count = var.system_node_count

  system_node_vm_size = var.system_node_vm_size

  system_node_min_count = var.system_node_min_count

  system_node_max_count = var.system_node_max_count

  enable_node_autoscaling = var.enable_node_autoscaling

  # =====================================
  # SPOT NODE POOL
  # =====================================

  enable_spot_node_pool = var.enable_spot_node_pool

  spot_node_pool_name = var.spot_node_pool_name

  spot_node_vm_size = var.spot_node_vm_size

  spot_max_price = var.spot_max_price

  spot_node_min_count = var.spot_node_min_count

  spot_node_max_count = var.spot_node_max_count

  spot_node_labels = var.spot_node_labels

  spot_node_taints = var.spot_node_taints

  # =====================================
  # AKS NETWORKING
  # =====================================

  subnet_id = module.network.subnet_id

  service_cidr = var.service_cidr

  dns_service_ip = var.dns_service_ip

  # =====================================
  # MONITORING
  # =====================================

  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id

  azure_monitor_workspace_id = try(
    module.monitoring.monitor_workspace_id,
    null
  )

  # =====================================
  # ENVIRONMENT
  # =====================================

  environment = var.environment

  # =====================================
  # OPTIONAL FUTURE AKS FEATURES
  # =====================================

  enable_workload_identity = var.enable_workload_identity

  enable_oidc_issuer = var.enable_oidc_issuer

  enable_image_cleaner = var.enable_image_cleaner

  image_cleaner_interval_hours = var.image_cleaner_interval_hours

  node_labels = var.node_labels

  node_taints = var.node_taints

  enable_api_server_access_profile = var.enable_api_server_access_profile

  authorized_ip_ranges = var.authorized_ip_ranges

  additional_tags = var.aks_additional_tags

  depends_on = [
    module.network,
    module.monitoring
  ]
}

# =====================================
# AKS READINESS WAIT
# =====================================

resource "time_sleep" "wait_for_aks" {

  depends_on = [
    module.aks
  ]

  create_duration = "120s"
}

# =====================================
# NAMESPACE MODULE
# =====================================

module "namespace" {

  source = "../../modules/employee_namespace"

  namespace_name = var.namespace_name

  namespace_labels = var.namespace_labels

  namespace_annotations = {}

  depends_on = [
    time_sleep.wait_for_aks
  ]
}

# =====================================
# RBAC MODULE
# =====================================

module "rbac" {

  source = "../../modules/employee_rbac"

  namespace_name = var.namespace_name

  service_account_name = var.service_account_name

  role_name = var.role_name

  allowed_resources = var.allowed_resources

  allowed_verbs = var.allowed_verbs

  service_account_annotations = {}

  role_annotations = {}

  role_binding_annotations = {}

  additional_labels = {}

  additional_annotations = {}

  depends_on = [
    module.namespace
  ]
}

# =====================================
# SECRET MODULE
# =====================================

module "secret" {

  source = "../../modules/employee_secret"

  namespace_name = var.namespace_name

  secret_name = var.secret_name

  secret_data = var.secret_data

  secret_annotations = {}

  additional_labels = {}

  additional_annotations = {}

  secret_type = "Opaque"

  secret_immutable = false

  depends_on = [
    module.namespace,
    time_sleep.wait_for_aks
  ]
}

# =====================================
# INGRESS MODULE
# =====================================

module "ingress" {

  source = "../../modules/employee_ingress"

  namespace_name = var.namespace_name

  ingress_name = var.ingress_name

  service_name = var.service_name

  ingress_host = var.ingress_host

  ingress_path = var.ingress_path

  ingress_path_type = var.ingress_path_type

  enable_tls = var.enable_tls

  tls_secret_name = var.tls_secret_name

  # =====================================
  # Optional Future Ingress Features
  # =====================================

  ingress_class_name = var.ingress_class_name

  enable_rewrite_target = false

  enable_proxy_body_size = false

  proxy_body_size = "10m"

  cluster_issuer = null

  depends_on = [
    module.namespace,
    time_sleep.wait_for_aks
  ]
}

# =====================================
# GOVERNANCE MODULE
# =====================================

module "governance" {

  source = "../../modules/employee_governance"

  namespace_name = var.namespace_name

  quota_limits = var.quota_limits

  limit_min = var.limit_min

  limit_max = var.limit_max

  limit_default = var.limit_default

  limit_default_request = var.limit_default_request

  labels = {}

  annotations = {}

  additional_labels = {}

  additional_annotations = {}

  resource_quota_annotations = {}

  limit_range_annotations = {}

  depends_on = [
    module.namespace
  ]
}