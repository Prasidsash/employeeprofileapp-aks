# =====================================
# MANAGED IDENTITY CLIENT ID
# =====================================

output "workload_identity_client_id" {

  description = "Workload Identity Client ID"

  value = try(
    azurerm_user_assigned_identity.workload_identity[0].client_id,
    null
  )
}

# =====================================
# MANAGED IDENTITY PRINCIPAL ID
# =====================================

output "workload_identity_principal_id" {

  description = "Workload Identity Principal ID"

  value = try(
    azurerm_user_assigned_identity.workload_identity[0].principal_id,
    null
  )
}