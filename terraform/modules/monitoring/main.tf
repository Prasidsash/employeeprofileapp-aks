resource "azurerm_log_analytics_workspace" "law" {

  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_in_days
}

# =====================================
# ACTION GROUP
# =====================================

resource "azurerm_monitor_action_group" "alerts" {

  count = var.enable_alerts ? 1 : 0

  name                = "${var.environment}-alerts"
  resource_group_name = var.resource_group_name
  short_name          = "alerts"
}

# =====================================
# MANAGED PROMETHEUS
# =====================================

resource "azurerm_monitor_workspace" "prometheus" {

  count = var.enable_managed_prometheus ? 1 : 0

  name                = "${var.environment}-amw"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# =====================================
# MANAGED GRAFANA
# =====================================

resource "azurerm_dashboard_grafana" "grafana" {

  count = var.enable_managed_prometheus ? 1 : 0

  name                = "${var.environment}-grafana"
  location            = var.location
  resource_group_name = var.resource_group_name

  grafana_major_version = 11

  api_key_enabled = true

  identity {
    type = "SystemAssigned"
  }
}