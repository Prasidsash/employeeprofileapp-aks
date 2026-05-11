data "azurerm_client_config" "current" {}

resource "azurerm_kubernetes_cluster" "aks" {

  name                = var.cluster_name

  location            = var.location

  resource_group_name = var.resource_group_name

  dns_prefix          = "${var.environment}-aks"

  kubernetes_version  = var.kubernetes_version

  # =====================================
  # Prevent Accidental Destroy
  # =====================================

  lifecycle {
    prevent_destroy = true
  }

  # =====================================
  # AKS Security Hardening
  # =====================================

  role_based_access_control_enabled = true

  azure_policy_enabled = true

  local_account_disabled = false

  # =====================================
  # Default System Node Pool
  # =====================================

  default_node_pool {

    name = "system"

    node_count = var.system_node_count

    vm_size = var.system_node_vm_size

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
  # Azure AD + Azure RBAC
  # =====================================

  azure_active_directory_role_based_access_control {

    azure_rbac_enabled = true

    tenant_id = data.azurerm_client_config.current.tenant_id
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
  # Monitoring Integration
  # =====================================

  dynamic "oms_agent" {

    for_each = var.log_analytics_workspace_id != null ? [1] : []

    content {

      log_analytics_workspace_id = var.log_analytics_workspace_id
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