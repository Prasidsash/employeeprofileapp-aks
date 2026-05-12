output "aks_name" {
  value = module.aks.cluster_name
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "log_analytics_workspace_id" {
  value = module.monitoring.workspace_id
}