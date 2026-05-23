# =====================================
# USER ASSIGNED MANAGED IDENTITY
# =====================================

resource "azurerm_user_assigned_identity" "workload_identity" {

  count = var.enable_workload_identity_resources ? 1 : 0

  name = "employeeprofileapp-${var.environment}-wi"

  location = var.location

  resource_group_name = var.resource_group_name

  tags = merge(

    {
      environment = var.environment

      project = "employeeprofileapp"

      managed_by = "terraform"
    },

    var.additional_tags
  )
}

# =====================================
# FEDERATED IDENTITY CREDENTIAL
# =====================================

resource "azurerm_federated_identity_credential" "workload_identity" {

  count = var.enable_workload_identity_resources ? 1 : 0

  name = "employeeprofileapp-${var.environment}-fic"
  
  audience = [
    "api://AzureADTokenExchange"
  ]

  issuer = var.oidc_issuer_url

  parent_id = azurerm_user_assigned_identity.workload_identity[0].id

  subject = "system:serviceaccount:${var.namespace_name}:${var.service_account_name}"
}

# =====================================
# KEY VAULT RBAC
# =====================================

resource "azurerm_role_assignment" "keyvault_secrets_user" {

  count = var.enable_workload_identity_resources ? 1 : 0

  scope = var.key_vault_id

  role_definition_name = "Key Vault Secrets User"

  principal_id = azurerm_user_assigned_identity.workload_identity[0].principal_id
}