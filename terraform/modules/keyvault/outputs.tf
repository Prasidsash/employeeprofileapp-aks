# =====================================
# FILE: terraform/modules/keyvault/outputs.tf
# VERSION: v4-enterprise-disposable-final
# =====================================

# =====================================
# KEY VAULT
# =====================================

output "key_vault_id" {

  description = "Key Vault resource ID"

  value = azurerm_key_vault.kv.id
}

output "key_vault_name" {

  description = "Key Vault name"

  value = azurerm_key_vault.kv.name
}

output "key_vault_uri" {

  description = "Key Vault URI"

  value = azurerm_key_vault.kv.vault_uri
}

# =====================================
# TENANT OUTPUT
# USED BY:
# - AKS
# - HELM
# - WORKLOAD IDENTITY
# - CSI DRIVER
# =====================================

output "tenant_id" {

  description = "Azure Tenant ID"

  value = azurerm_key_vault.kv.tenant_id
}

# =====================================
# KEY VAULT RESOURCE GROUP
# =====================================

output "key_vault_resource_group_name" {

  description = "Key Vault Resource Group Name"

  value = azurerm_key_vault.kv.resource_group_name
}

# =====================================
# OPTIONAL RBAC OUTPUTS
# =====================================

output "key_vault_admin_role_assignment_id" {

  description = "Key Vault Administrator RBAC Assignment ID"

  value = azurerm_role_assignment.kv_admin.id
}

output "aks_keyvault_secrets_user_role_assignment_id" {

  description = "AKS Key Vault Secrets User Role Assignment ID"

  value = try(
    azurerm_role_assignment.aks_kv_secrets_user[0].id,
    null
  )
}