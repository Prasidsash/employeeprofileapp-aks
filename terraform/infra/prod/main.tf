# =====================================
# FILE: terraform/infra/prod/main.tf
# VERSION: v7-enterprise-disposable-final
# =====================================

# =====================================
# LOCAL VALUES
# =====================================

locals {

  common_tags = {

    environment = var.environment

    project = "employeeprofileapp"

    managed_by = "terraform"
  }
}

# =====================================
# RESOURCE GROUP
# =====================================

resource "azurerm_resource_group" "main" {

  name = var.resource_group_name

  location = var.location

  tags = local.common_tags
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

  depends_on = [
    azurerm_resource_group.main
  ]
}

# =====================================
# MONITORING MODULE
# =====================================

module "monitoring" {

  count = var.enable_monitoring ? 1 : 0

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

  additional_tags = var.monitoring_additional_tags

  depends_on = [
    azurerm_resource_group.main
  ]
}

# =====================================
# ACR MODULE
# =====================================

module "acr" {

  count = var.enable_acr ? 1 : 0

  source = "../../modules/acr"

  acr_name = var.acr_name

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  acr_sku = var.acr_sku

  environment = var.environment

  additional_tags = var.aks_additional_tags

  depends_on = [
    azurerm_resource_group.main
  ]
}

# =====================================
# ENTERPRISE UAMI MODULE
# PHASE-2 IDENTITY LIFECYCLE
# =====================================

module "aks_workload_identity" {

  count = var.enable_user_assigned_identity ? 1 : 0

  source = "../../modules/uami"

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  environment = var.environment

  identity_name = "${var.cluster_name}-wi"

  additional_tags = local.common_tags

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

  environment = var.environment

  # =====================================
  # SYSTEM NODE POOL
  # =====================================

  system_node_count = var.system_node_count

  system_node_vm_size = var.system_node_vm_size

  enable_node_autoscaling = var.enable_node_autoscaling

  system_node_min_count = var.system_node_min_count

  system_node_max_count = var.system_node_max_count

  only_critical_addons_enabled = var.only_critical_addons_enabled

  node_labels = var.node_labels

  node_taints = var.node_taints

  # =====================================
  # NETWORKING
  # =====================================

  subnet_id = module.network.subnet_id

  service_cidr = var.service_cidr

  dns_service_ip = var.dns_service_ip

  # =====================================
  # ENTERPRISE OIDC + WORKLOAD IDENTITY
  # =====================================

  enable_oidc_issuer = var.enable_oidc_issuer

  enable_workload_identity = var.enable_workload_identity

  # =====================================
  # USER ASSIGNED MANAGED IDENTITY
  # =====================================

  enable_user_assigned_identity = var.enable_user_assigned_identity

  user_assigned_identity_ids = var.enable_user_assigned_identity ? [

    module.aks_workload_identity[0].identity_id

  ] : var.user_assigned_identity_ids

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
  # MONITORING
  # =====================================

  enable_monitoring = var.enable_monitoring

  log_analytics_workspace_id = try(
    module.monitoring[0].log_analytics_workspace_id,
    null
  )

  azure_monitor_workspace_id = try(
    module.monitoring[0].monitor_workspace_id,
    null
  )

  # =====================================
  # KEY VAULT CSI DRIVER
  # =====================================

  enable_key_vault_secrets_provider = var.enable_key_vault_secrets_provider

  secret_rotation_enabled = var.secret_rotation_enabled

  # =====================================
  # IMAGE CLEANER
  # =====================================

  enable_image_cleaner = var.enable_image_cleaner

  image_cleaner_interval_hours = var.image_cleaner_interval_hours

  # =====================================
  # API SERVER ACCESS PROFILE
  # =====================================

  enable_api_server_access_profile = var.enable_api_server_access_profile

  authorized_ip_ranges = var.authorized_ip_ranges

  # =====================================
  # TAGS
  # =====================================

  additional_tags = merge(

    local.common_tags,

    var.aks_additional_tags
  )

  # =====================================
  # ACR AUTOMATION
  # =====================================

  enable_acr_pull_role_assignment = true

  acr_id = try(
    module.acr[0].acr_id,
    null
  )

  depends_on = [
    module.network,
    module.monitoring,
    module.acr,
    module.aks_workload_identity
  ]
}

# =====================================
# AKS READINESS WAIT
# =====================================

resource "time_sleep" "wait_for_aks" {

  depends_on = [
    module.aks
  ]

  create_duration = "240s"
}

# =====================================
# FEDERATED CREDENTIAL MODULE
# PHASE-2 IDENTITY LIFECYCLE
# =====================================

module "federated_identity" {

  count = var.enable_user_assigned_identity ? 1 : 0

  source = "../../modules/federated_identity"

  resource_group_name = azurerm_resource_group.main.name

  namespace = var.namespace_name

  service_account_name = var.service_account_name

  identity_name = module.aks_workload_identity[0].identity_name

  identity_resource_group_name = azurerm_resource_group.main.name

  user_assigned_identity_id = module.aks_workload_identity[0].identity_id

  oidc_issuer_url = module.aks.aks_oidc_issuer_url

  depends_on = [
    module.aks,
    module.aks_workload_identity,
    time_sleep.wait_for_aks
  ]
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
  # KEY VAULT ADMIN RBAC
  # =====================================

  keyvault_admin_object_id = coalesce(
    var.keyvault_admin_object_id,
    data.azurerm_client_config.current.object_id
  )

  # =====================================
  # AKS CSI RBAC
  # =====================================

  enable_aks_kv_rbac = true

  aks_kubelet_object_id = module.aks.aks_kubelet_object_id

  # =====================================
  # WORKLOAD IDENTITY KEYVAULT ACCESS
  # =====================================

  enable_workload_identity_keyvault_access = true

  workload_identity_principal_id = try(
    module.aks_workload_identity[0].principal_id,
    null
  )

  # =====================================
  # DEFAULT SECRETS
  # =====================================

  enable_default_key_vault_secrets = var.enable_default_key_vault_secrets

  db_username = var.db_username

  db_password = var.db_password

  # =====================================
  # OPTIONAL FEATURES
  # =====================================

  enable_network_acls = var.enable_network_acls

  additional_tags = merge(

    local.common_tags,

    var.keyvault_additional_tags
  )

  depends_on = [
    module.aks,
    module.aks_workload_identity,
    time_sleep.wait_for_aks
  ]
}

# =====================================
# NAMESPACE MODULE
# =====================================

module "namespace" {

  source = "../../modules/employee_namespace"

  environment = var.environment

  namespace_name = var.namespace_name

  namespace_labels = var.namespace_labels

  namespace_annotations = var.namespace_annotations

  depends_on = [
    module.aks,
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

  service_account_annotations = {

    "azure.workload.identity/client-id" = try(
      module.aks_workload_identity[0].client_id,
      ""
    )
  }

  role_annotations = var.role_annotations

  role_binding_annotations = var.role_binding_annotations

  additional_labels = var.rbac_additional_labels

  additional_annotations = var.rbac_additional_annotations

  depends_on = [
    module.namespace,
    module.federated_identity
  ]
}

# =====================================
# INGRESS NGINX CONTROLLER
# =====================================

module "ingress_nginx" {

  count = var.enable_ingress_controller ? 1 : 0

  source = "../../modules/ingress_nginx"

  namespace = var.ingress_controller_namespace

  chart_version = var.ingress_controller_chart_version

  service_type = var.ingress_controller_service_type

  replica_count = var.ingress_controller_replica_count

  depends_on = [
    module.aks,
    module.namespace,
    time_sleep.wait_for_aks
  ]
}

# =====================================
# CERT MANAGER MODULE
# =====================================

module "cert_manager" {

  count = var.enable_cert_manager ? 1 : 0

  source = "../../modules/cert_manager"

  providers = {

    helm    = helm
    kubectl = kubectl
  }

  namespace = var.cert_manager_namespace

  chart_version = var.cert_manager_chart_version

  enable_cluster_issuer = var.enable_cluster_issuer

  cluster_issuer_name = var.cluster_issuer_name

  depends_on = [
    module.aks,
    module.ingress_nginx,
    time_sleep.wait_for_aks
  ]
}

# =====================================
# INGRESS MODULE
# =====================================

module "ingress" {

  count = var.enable_ingress ? 1 : 0

  source = "../../modules/employee_ingress"

  namespace_name = var.namespace_name

  ingress_name = var.ingress_name

  service_name = var.service_name

  ingress_host = var.ingress_host

  ingress_path = var.ingress_path

  ingress_path_type = var.ingress_path_type

  enable_tls = var.enable_tls

  tls_secret_name = var.tls_secret_name

  ingress_class_name = var.ingress_class_name

  enable_rewrite_target = var.enable_rewrite_target

  enable_proxy_body_size = var.enable_proxy_body_size

  proxy_body_size = var.proxy_body_size

  cluster_issuer = var.cluster_issuer

  depends_on = [
    module.namespace,
    time_sleep.wait_for_aks
  ]
}

# =====================================
# GOVERNANCE MODULE
# =====================================

module "governance" {

  count = var.enable_governance ? 1 : 0

  source = "../../modules/employee_governance"

  namespace_name = var.namespace_name

  quota_limits = var.quota_limits

  limit_min = var.limit_min

  limit_max = var.limit_max

  limit_default = var.limit_default

  limit_default_request = var.limit_default_request

  labels = var.governance_labels

  annotations = var.governance_annotations

  additional_labels = {}

  additional_annotations = {}

  resource_quota_annotations = {}

  limit_range_annotations = {}

  enable_pod_disruption_budget = var.enable_pod_disruption_budget

  pod_disruption_budget_name = var.pod_disruption_budget_name

  pdb_max_unavailable = var.pdb_max_unavailable

  pdb_match_labels = var.pdb_match_labels

  pod_disruption_budget_annotations = var.pod_disruption_budget_annotations

  depends_on = [
    module.namespace
  ]
}