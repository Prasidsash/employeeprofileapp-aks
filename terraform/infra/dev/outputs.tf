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

output "tenant_id" {

  description = "Azure Tenant ID"

  value = module.keyvault.tenant_id
}

# =====================================
# INGRESS
# =====================================

output "ingress_host" {

  description = "Ingress Host"

  value = var.ingress_host
}

# =====================================
# TLS
# =====================================

output "tls_enabled" {

  description = "TLS Enabled Status"

  value = var.enable_tls
}