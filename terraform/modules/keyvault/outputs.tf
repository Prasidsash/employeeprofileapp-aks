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
# OPTIONAL RBAC OUTPUT
# =====================================

output "key_vault_role_assignment_id" {

  description = "Key Vault RBAC role assignment ID"

  value = azurerm_role_assignment.kv_admin.id
}

# =====================================
# OPTIONAL TENANT OUTPUT
# =====================================

output "key_vault_tenant_id" {

  description = "Key Vault tenant ID"

  value = azurerm_key_vault.kv.tenant_id
}

# =====================================
# OPTIONAL KEY VAULT NAME OUTPUT
# FOR FUTURE CSI / WORKLOAD IDENTITY
# =====================================

output "key_vault_resource_group_name" {

  description = "Key Vault Resource Group Name"

  value = azurerm_key_vault.kv.resource_group_name
}

output "tenant_id" {

  description = "Azure Tenant ID"

  value = azurerm_key_vault.kv.tenant_id
}