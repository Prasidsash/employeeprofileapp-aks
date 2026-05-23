# =====================================
# AKS
# =====================================

output "aks_name" {

  description = "AKS cluster name"

  value = module.aks.cluster_name
}

output "aks_cluster_id" {

  description = "AKS Cluster ID"

  value = module.aks.cluster_id
}

output "aks_kubernetes_version" {

  description = "AKS Kubernetes Version"

  value = module.aks.kubernetes_version
}

# =====================================
# RESOURCE GROUP
# =====================================

output "resource_group_name" {

  description = "Resource group name"

  value = var.resource_group_name
}

# =====================================
# NETWORK
# =====================================

output "subnet_id" {

  description = "AKS subnet ID"

  value = module.network.subnet_id
}

# =====================================
# NAMESPACE
# =====================================

output "namespace_name" {

  description = "Kubernetes Namespace"

  value = var.namespace_name
}

# =====================================
# MONITORING
# (Preserved exactly as requested)
# =====================================

output "log_analytics_workspace_id" {

  description = "Log Analytics Workspace ID"

  value = try(
    module.monitoring[0].log_analytics_workspace_id,
    null
  )
}

# =====================================
# OPTIONAL MANAGED PROMETHEUS
# =====================================

output "monitor_workspace_id" {

  description = "Azure Monitor Workspace ID"

  value = try(
    module.monitoring[0].monitor_workspace_id,
    null
  )
}

# =====================================
# OPTIONAL MANAGED GRAFANA
# =====================================

output "grafana_id" {

  description = "Managed Grafana ID"

  value = try(
    module.monitoring[0].grafana_id,
    null
  )
}

# =====================================
# KEY VAULT
# Existing resources only
# =====================================

output "key_vault_id" {

  description = "Key Vault ID"

  value = module.keyvault.key_vault_id
}

output "key_vault_name" {

  description = "Key Vault Name"

  value = module.keyvault.key_vault_name
}

output "key_vault_uri" {

  description = "Key Vault URI"

  value = module.keyvault.key_vault_uri
}

# =====================================
# AKS BACKUP
# =====================================

output "backup_vault_name" {

  description = "AKS Backup Vault Name"

  value = try(module.aks_backup[0].backup_vault_name, null)
}

output "backup_vault_id" {

  description = "AKS Backup Vault ID"

  value = try(module.aks_backup[0].backup_vault_id, null)
}

output "backup_policy_id" {

  description = "AKS Backup Policy ID"

  value = try(module.aks_backup[0].backup_policy_id, null)
}

output "backup_instance_id" {

  description = "AKS Backup Instance ID"

  value = try(module.aks_backup[0].backup_instance_id, null)
}

output "backup_storage_account_name" {

  description = "Backup Storage Account Name"

  value = try(module.aks_backup[0].backup_storage_account_name, null)
}

# =====================================
# OPTIONAL FUTURE INGRESS OUTPUTS
# =====================================

output "ingress_host" {

  description = "Ingress Host"

  value = var.ingress_host
}

# =====================================
# OPTIONAL FUTURE TLS STATUS
# =====================================

output "tls_enabled" {

  description = "TLS Enabled Status"

  value = var.enable_tls
}

# =====================================
# WORKLOAD IDENTITY
# =====================================

output "workload_identity_client_id" {

  description = "Workload Identity Client ID"

  value = module.workload_identity.workload_identity_client_id
}

output "workload_identity_principal_id" {

  description = "Workload Identity Principal ID"

  value = module.workload_identity.workload_identity_principal_id
}