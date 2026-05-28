output "aks_oidc_issuer_url" {
  value = module.aks.aks_oidc_issuer_url
}

output "workload_identity_id" {
  value = module.aks_workload_identity[0].identity_id
}

output "workload_identity_name" {
  value = module.aks_workload_identity[0].identity_name
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "namespace_name" {
  value = var.namespace_name
}

output "service_account_name" {
  value = var.service_account_name
}