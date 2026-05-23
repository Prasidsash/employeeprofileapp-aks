resource "azurerm_kubernetes_cluster" "aks" {

  name                = var.cluster_name

  location            = var.location

  resource_group_name = var.resource_group_name

  dns_prefix          = "${var.cluster_name}-${var.environment}"

  kubernetes_version  = var.kubernetes_version

  sku_tier            = "Standard"

  oidc_issuer_enabled = var.enable_oidc_issuer

  workload_identity_enabled = var.enable_workload_identity

  # =====================================
  # DEFAULT SYSTEM NODE POOL
  # =====================================

  default_node_pool {

    name = "system"

    vm_size = var.system_node_vm_size

    node_count = var.system_node_count

    auto_scaling_enabled = var.enable_node_autoscaling

    min_count = var.system_node_min_count

    max_count = var.system_node_max_count

    vnet_subnet_id = var.subnet_id

    temporary_name_for_rotation = "tempsys"

    only_critical_addons_enabled = var.only_critical_addons_enabled

    node_labels = var.node_labels
  }

  # =====================================
  # SYSTEM ASSIGNED IDENTITY
  # =====================================

  dynamic "identity" {

    for_each = var.enable_user_assigned_identity ? [] : [1]

    content {

      type = "SystemAssigned"
    }
  }

  # =====================================
  # USER ASSIGNED IDENTITY
  # =====================================

  dynamic "identity" {

    for_each = var.enable_user_assigned_identity ? [1] : []

    content {

      type = "UserAssigned"

      identity_ids = var.user_assigned_identity_ids
    }
  }

  # =====================================
  # NETWORK PROFILE
  # =====================================

  network_profile {

    network_plugin = "azure"

    network_policy = "azure"

    service_cidr = var.service_cidr

    dns_service_ip = var.dns_service_ip

    load_balancer_sku = "standard"
  }

  # =====================================
  # OMS AGENT
  # =====================================

  dynamic "oms_agent" {

    for_each = var.enable_monitoring ? [1] : []

    content {

      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  # =====================================
  # AZURE MONITOR METRICS
  # =====================================

  dynamic "monitor_metrics" {

  for_each = var.azure_monitor_workspace_id != null ? [1] : []

  content {

    annotations_allowed = null

    labels_allowed = null
  }
}

  # =====================================
  # IMAGE CLEANER
  # =====================================

  image_cleaner_enabled = var.enable_image_cleaner

  image_cleaner_interval_hours = var.image_cleaner_interval_hours

  # =====================================
  # KEY VAULT CSI DRIVER
  # =====================================

  dynamic "key_vault_secrets_provider" {

    for_each = var.enable_key_vault_secrets_provider ? [1] : []

    content {

      secret_rotation_enabled = var.secret_rotation_enabled
    }
  }

  # =====================================
  # API SERVER ACCESS PROFILE
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
      managed_by  = "terraform"
      module      = "aks"
    },

    var.additional_tags
  )
}

# =====================================
# OPTIONAL SPOT NODE POOL
# =====================================

resource "azurerm_kubernetes_cluster_node_pool" "spot" {

  count = var.enable_spot_node_pool ? 1 : 0

  name = var.spot_node_pool_name

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

  vm_size = var.spot_node_vm_size

  priority = "Spot"

  eviction_policy = "Delete"

  spot_max_price = var.spot_max_price

  auto_scaling_enabled = true

  min_count = var.spot_node_min_count

  max_count = var.spot_node_max_count

  mode = "User"

  orchestrator_version = var.kubernetes_version

  vnet_subnet_id = var.subnet_id

  node_labels = merge(

    {
      workload = "spot"
    },

    var.spot_node_labels
  )

  node_taints = concat(

    [
      "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
    ],

    var.spot_node_taints
  )

  tags = merge(

    {
      environment = var.environment
      managed_by  = "terraform"
      module      = "aks-spotpool"
    },

    var.additional_tags
  )
}

# =====================================
# OPTIONAL ACR PULL ROLE ASSIGNMENT
# =====================================

resource "azurerm_role_assignment" "aks_acr_pull" {

  count = var.enable_acr_pull_role_assignment ? 1 : 0

  scope = var.acr_id

  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}