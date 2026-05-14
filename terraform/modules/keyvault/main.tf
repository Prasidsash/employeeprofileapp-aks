# =====================================
# Current Azure Client Info
# =====================================

data "azurerm_client_config" "current" {}

# =====================================
# Local Values
# =====================================

locals {

  key_vault_base_name = lower(
    replace(
      replace(var.resource_group_name, "-rg", ""),
      "_",
      "-"
    )
  )

  key_vault_name = "${substr(local.key_vault_base_name,0,18)}-kv"
}

# =====================================
# Key Vault
# =====================================

resource "azurerm_key_vault" "kv" {

  name                = local.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  rbac_authorization_enabled = true

  tags = {

    environment = var.environment
    project     = "employeeprofileapp"
    managed_by  = "terraform"
  }
}

# =====================================
# RBAC FOR KEY VAULT
# =====================================

resource "azurerm_role_assignment" "kv_admin" {

  scope = azurerm_key_vault.kv.id

  role_definition_name = "Key Vault Administrator"

  principal_id = data.azurerm_client_config.current.object_id
}

# =====================================
# Optional Sample Secret
# Lab-safe behavior
# =====================================

resource "azurerm_key_vault_secret" "app_secret" {

  count = 0

  name  = "employee-db-connection"
  value = "sample-secret-value"

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_role_assignment.kv_admin
  ]
}