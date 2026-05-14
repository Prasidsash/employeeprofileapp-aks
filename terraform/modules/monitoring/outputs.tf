output "log_analytics_workspace_id" {

  description = "Log Analytics Workspace ID"

  value = azurerm_log_analytics_workspace.law.id
}

output "log_analytics_workspace_name" {

  description = "Log Analytics Workspace Name"

  value = azurerm_log_analytics_workspace.law.name
}

# =====================================
# MANAGED PROMETHEUS
# =====================================

output "azure_monitor_workspace_id" {

  description = "Azure Monitor Workspace ID"

  value = var.enable_managed_prometheus ? azurerm_monitor_workspace.prometheus[0].id : null
}

# =====================================
# GRAFANA
# =====================================

output "grafana_id" {

  description = "Managed Grafana ID"

  value = var.enable_managed_prometheus ? azurerm_dashboard_grafana.grafana[0].id : null
}