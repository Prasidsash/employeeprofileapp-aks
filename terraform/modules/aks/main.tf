data "azurerm_client_config" "current" {}

resource "azurerm_kubernetes_cluster" "aks" {

  name = var.cluster_name

  location = var.location

  resource_group_name = var.resource_group_name

  dns_prefix = "${var.environment}-aks"

  kubernetes_version = var.kubernetes_version

  # =====================================
  # Prevent Accidental Destroy
  # =====================================

  lifecycle {

    prevent_destroy = false
  }

  # =====================================
  # AKS Security Hardening
  # =====================================

  role_based_access_control_enabled = true

  azure_policy_enabled = true

  local_account_disabled = false

  # =====================================
  # Optional Future Features
  # Preserve Existing Cluster Behavior
  # =====================================

  sku_tier = "Free"

  # =====================================
  # OPTIONAL WORKLOAD IDENTITY
  # =====================================

  workload_identity_enabled = var.enable_workload_identity

  oidc_issuer_enabled = var.enable_oidc_issuer

  # =====================================
  # OPTIONAL IMAGE CLEANER
  # =====================================

  image_cleaner_enabled = var.enable_image_cleaner

  image_cleaner_interval_hours = var.image_cleaner_interval_hours

  # =====================================
  # DEFAULT SYSTEM NODE POOL
  # =====================================

  default_node_pool {

    name = "system"

    temporary_name_for_rotation = "systemtemp"

    node_count = var.enable_node_autoscaling ? null : var.system_node_count

    vm_size = var.system_node_vm_size

    auto_scaling_enabled = var.enable_node_autoscaling

    min_count = var.enable_node_autoscaling ? var.system_node_min_count : null

    max_count = var.enable_node_autoscaling ? var.system_node_max_count : null

    vnet_subnet_id = var.subnet_id

    orchestrator_version = var.kubernetes_version

    node_labels = var.node_labels

    upgrade_settings {

      max_surge = "10%"
    }
  }

  # =====================================
  # MANAGED IDENTITY
  # =====================================

  identity {

    type = "SystemAssigned"
  }

  # =====================================
  # NETWORK PROFILE
  # =====================================

  network_profile {

    network_plugin = "azure"

    network_policy = "azure"

    load_balancer_sku = "standard"

    service_cidr = var.service_cidr

    dns_service_ip = var.dns_service_ip
  }

  # =====================================
  # OMS / LOG ANALYTICS
  # =====================================

  dynamic "oms_agent" {

    for_each = var.log_analytics_workspace_id != null ? [1] : []

    content {

      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  # =====================================
  # MANAGED PROMETHEUS
  # =====================================

  dynamic "monitor_metrics" {

    for_each = var.azure_monitor_workspace_id != null ? [1] : []

    content {

      annotations_allowed = null

      labels_allowed = null
    }
  }

  # =====================================
  # OPTIONAL API SERVER ACCESS PROFILE
  # =====================================

  dynamic "api_server_access_profile" {

    for_each = var.enable_api_server_access_profile ? [1] : []

    content {

      authorized_ip_ranges = var.authorized_ip_ranges
    }
  }

  # =====================================
  # TAGS
  # =====================================

  tags = merge(

    {
      environment = var.environment

      managed_by = "terraform"

      project = "employeeprofileapp"
    },

    var.additional_tags
  )
}

# =====================================
# ADDITIVE SPOT NODE POOL
# SAFE LOW-COST SCALABILITY TESTING
# =====================================

resource "azurerm_kubernetes_cluster_node_pool" "spot" {

  count = var.enable_spot_node_pool ? 1 : 0

  name = var.spot_node_pool_name

  temporary_name_for_rotation = "spottemp"

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

  vm_size = var.spot_node_vm_size

  mode = "User"

  priority = "Spot"

  eviction_policy = "Delete"

  spot_max_price = var.spot_max_price

  auto_scaling_enabled = true

  min_count = var.spot_node_min_count

  max_count = var.spot_node_max_count

  vnet_subnet_id = var.subnet_id

  orchestrator_version = var.kubernetes_version

  node_labels = var.spot_node_labels

  node_taints = var.spot_node_taints

  tags = merge(

    {
      environment = var.environment

      managed_by = "terraform"

      project = "employeeprofileapp"

      nodepool = "spot"
    },

    var.additional_tags
  )
}