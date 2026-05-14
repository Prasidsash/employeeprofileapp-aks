# =====================================
# AKS
# =====================================

output "aks_name" {

  description = "AKS cluster name"

  value = module.aks.cluster_name
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
# MONITORING
# (Preserved exactly as requested)
# =====================================

output "log_analytics_workspace_id" {

  description = "Log Analytics Workspace ID"

  value = module.monitoring.log_analytics_workspace_id
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