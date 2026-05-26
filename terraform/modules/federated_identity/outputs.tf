# =====================================
# FILE: terraform/modules/federated_identity/outputs.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

output "federated_identity_credential_id" {

  description = "Federated Identity Credential ID"

  value = azurerm_federated_identity_credential.workload_identity.id
}

output "federated_identity_credential_name" {

  description = "Federated Identity Credential Name"

  value = azurerm_federated_identity_credential.workload_identity.name
}