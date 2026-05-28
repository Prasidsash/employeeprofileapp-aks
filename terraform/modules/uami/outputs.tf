# =====================================
# FILE:
# terraform/modules/uami/outputs.tf
# VERSION:
# v3-enterprise-workloadidentity-runtime-final
# =====================================

output "identity_id" {

  description = "User Assigned Identity ID"

  value = azurerm_user_assigned_identity.uami.id
}

output "client_id" {

  description = "User Assigned Identity Client ID"

  value = azurerm_user_assigned_identity.uami.client_id
}

output "principal_id" {

  description = "User Assigned Identity Principal ID"

  value = azurerm_user_assigned_identity.uami.principal_id
}

output "identity_name" {

  description = "User Assigned Identity Name"

  value = azurerm_user_assigned_identity.uami.name
}

output "tenant_id" {

  description = "Azure Tenant ID"

  value = azurerm_user_assigned_identity.uami.tenant_id
}