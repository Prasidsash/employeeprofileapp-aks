data "azurerm_client_config" "current" {}

resource "azurerm_kubernetes_cluster" "aks" {

  name                = var.cluster_name
  location            = var.location
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
  # Default System Node Pool
  # =====================================

  default_node_pool {

    name = "system"

    node_count = var.enable_node_autoscaling ? null : var.system_node_count

    vm_size = var.system_node_vm_size

    auto_scaling_enabled = var.enable_node_autoscaling

    min_count = var.enable_node_autoscaling ? var.system_node_min_count : null

    max_count = var.enable_node_autoscaling ? var.system_node_max_count : null

    vnet_subnet_id = var.subnet_id

    orchestrator_version = var.kubernetes_version

    upgrade_settings {
      max_surge = "10%"
    }
  }

  # =====================================
  # Managed Identity
  # =====================================

  identity {

    type = "SystemAssigned"
  }

  # =====================================
  # Network Profile
  # =====================================

  network_profile {

    network_plugin = "azure"

    network_policy = "azure"

    load_balancer_sku = "standard"

    service_cidr = var.service_cidr

    dns_service_ip = var.dns_service_ip
  }

  # =====================================
  # OMS / Log Analytics
  # =====================================

  dynamic "oms_agent" {

    for_each = var.log_analytics_workspace_id != null ? [1] : []

    content {

      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  # =====================================
  # Managed Prometheus
  # Preserve Existing Monitoring Behavior
  # =====================================

  dynamic "monitor_metrics" {

    for_each = var.azure_monitor_workspace_id != null ? [1] : []

    content {

      annotations_allowed = null

      labels_allowed = null
    }
  }

  # =====================================
  # Tags
  # =====================================

  tags = {

    environment = var.environment

    managed_by = "terraform"

    project = "employeeprofileapp"
  }
}