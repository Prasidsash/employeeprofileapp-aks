# =====================================
# LOG ANALYTICS WORKSPACE
# =====================================

resource "azurerm_log_analytics_workspace" "law" {

  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = var.log_analytics_sku

  retention_in_days = var.log_retention_in_days

  tags = {

    environment = var.environment

    managed_by = "terraform"

    project = "employeeprofileapp"
  }
}

# =====================================
# ACTION GROUP
# =====================================

resource "azurerm_monitor_action_group" "alerts" {

  count = var.enable_alerts ? 1 : 0

  name = "${var.environment}-alerts"

  resource_group_name = var.resource_group_name

  short_name = "alerts"

  tags = {

    environment = var.environment

    managed_by = "terraform"

    project = "employeeprofileapp"
  }
}

# =====================================
# AZURE MONITOR WORKSPACE
# (Managed Prometheus backend)
# =====================================

resource "azurerm_monitor_workspace" "prometheus" {

  count = var.enable_managed_prometheus ? 1 : 0

  name = "${var.environment}-amw"

  location = var.location

  resource_group_name = var.resource_group_name

  tags = {

    environment = var.environment

    managed_by = "terraform"

    project = "employeeprofileapp"
  }
}

# =====================================
# MANAGED GRAFANA
# =====================================

resource "azurerm_dashboard_grafana" "grafana" {

  count = var.enable_managed_prometheus ? 1 : 0

  name = "${var.environment}-grafana"

  location = var.location

  resource_group_name = var.resource_group_name

  grafana_major_version = 11

  api_key_enabled = true

  # =====================================
  # Optional Future Network Hardening
  # Preserve Existing Behavior
  # =====================================

  public_network_access_enabled = true

  identity {

    type = "SystemAssigned"
  }

  # =====================================
  # GRAFANA ↔ MONITOR WORKSPACE LINK
  # =====================================

  azure_monitor_workspace_integrations {

    resource_id = azurerm_monitor_workspace.prometheus[0].id
  }

  tags = {

    environment = var.environment

    managed_by = "terraform"

    project = "employeeprofileapp"
  }
}

# =====================================
# GRAFANA → MONITOR WORKSPACE ACCESS
# =====================================

resource "azurerm_role_assignment" "grafana_monitor_reader" {

  count = var.enable_managed_prometheus ? 1 : 0

  scope = azurerm_monitor_workspace.prometheus[0].id

  role_definition_name = "Monitoring Reader"

  principal_id = azurerm_dashboard_grafana.grafana[0].identity[0].principal_id
}