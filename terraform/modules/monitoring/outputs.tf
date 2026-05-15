# =====================================
# LOG ANALYTICS
# =====================================

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

output "monitor_workspace_id" {

  description = "Azure Monitor Workspace ID"

  value = var.enable_managed_prometheus ? azurerm_monitor_workspace.prometheus[0].id : null
}

output "monitor_workspace_name" {

  description = "Azure Monitor Workspace Name"

  value = var.enable_managed_prometheus ? azurerm_monitor_workspace.prometheus[0].name : null
}

# =====================================
# GRAFANA
# =====================================

output "grafana_id" {

  description = "Managed Grafana ID"

  value = var.enable_managed_prometheus ? azurerm_dashboard_grafana.grafana[0].id : null
}

output "grafana_name" {

  description = "Managed Grafana Name"

  value = var.enable_managed_prometheus ? azurerm_dashboard_grafana.grafana[0].name : null
}

output "grafana_endpoint" {

  description = "Managed Grafana Endpoint"

  value = var.enable_managed_prometheus ? azurerm_dashboard_grafana.grafana[0].endpoint : null
}