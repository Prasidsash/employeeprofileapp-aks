# =====================================
# FILE:
# terraform/modules/uami/main.tf
# VERSION:
# v3-enterprise-workloadidentity-federated-runtime-final
# =====================================

# =====================================
# USER ASSIGNED MANAGED IDENTITY
# =====================================

resource "azurerm_user_assigned_identity" "uami" {

  name = var.identity_name

  resource_group_name = var.resource_group_name

  location = var.location

  tags = merge(

    {
      environment = var.environment

      managed_by = "terraform"

      project = "employeeprofileapp"

      module = "uami"
    },

    var.additional_tags
  )
}

# =====================================
# FEDERATED IDENTITY CREDENTIAL
# =====================================

resource "azurerm_federated_identity_credential" "uami" {

  count = var.enable_federated_identity ? 1 : 0

  name = "${var.identity_name}-fic"

  resource_group_name = var.resource_group_name

  audience = [
    "api://AzureADTokenExchange"
  ]

  issuer = var.oidc_issuer_url

  parent_id = azurerm_user_assigned_identity.uami.id

  subject = "system:serviceaccount:${var.namespace_name}:${var.service_account_name}"

  depends_on = [
    azurerm_user_assigned_identity.uami
  ]
}

# =====================================
# KEY VAULT RBAC
# =====================================

resource "azurerm_role_assignment" "keyvault_secrets_user" {

  count = var.enable_federated_identity ? 1 : 0

  scope = var.key_vault_id

  role_definition_name = "Key Vault Secrets User"

  principal_id = azurerm_user_assigned_identity.uami.principal_id

  principal_type = "ServicePrincipal"

  depends_on = [
    azurerm_federated_identity_credential.uami
  ]
}

# =====================================
# WORKLOAD IDENTITY PROPAGATION WAIT
# =====================================

resource "time_sleep" "wait_for_workload_identity" {

  count = var.enable_federated_identity ? 1 : 0

  depends_on = [
    azurerm_federated_identity_credential.uami,
    azurerm_role_assignment.keyvault_secrets_user
  ]

  create_duration = "180s"
}

# =====================================
# OUTPUTS
# =====================================

output "identity_id" {

  value = azurerm_user_assigned_identity.uami.id
}

output "client_id" {

  value = azurerm_user_assigned_identity.uami.client_id
}

output "principal_id" {

  value = azurerm_user_assigned_identity.uami.principal_id
}