# =====================================
# Current Azure Client Info
# =====================================

data "azurerm_client_config" "current" {}

# =====================================
# Local Values
# =====================================

locals {

  # =====================================
  # CLEAN RESOURCE GROUP NAME
  # =====================================

  key_vault_base_name = lower(
    replace(
      replace(var.resource_group_name, "-rg", ""),
      "_",
      "-"
    )
  )

  # =====================================
  # ENVIRONMENT-SAFE KEY VAULT NAME
  # PRESERVES EXISTING OVERRIDE LOGIC
  # =====================================

  generated_key_vault_name = substr(
    "${local.key_vault_base_name}-kv",
    0,
    24
  )

  # =====================================
  # OPTIONAL CUSTOM NAME OVERRIDE
  # =====================================

  key_vault_name = var.key_vault_name != null ? var.key_vault_name : local.generated_key_vault_name
}

# =====================================
# KEY VAULT
# =====================================

resource "azurerm_key_vault" "kv" {

  name = local.key_vault_name

  location = var.location

  resource_group_name = var.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  # =====================================
  # LAB-SAFE SETTINGS
  # =====================================

  soft_delete_retention_days = 7

  purge_protection_enabled = false

  # =====================================
  # RBAC AUTHORIZATION
  # =====================================

  rbac_authorization_enabled = true

  # =====================================
  # OPTIONAL NETWORK ACL PLACEHOLDER
  # Preserve Existing Behavior
  # =====================================

  dynamic "network_acls" {

    for_each = var.enable_network_acls ? [1] : []

    content {

      bypass = "AzureServices"

      default_action = "Allow"
    }
  }

  # =====================================
  # TAGS
  # =====================================

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
# RBAC FOR KEY VAULT
# =====================================

resource "azurerm_role_assignment" "kv_admin" {

  scope = azurerm_key_vault.kv.id

  role_definition_name = var.keyvault_role_definition_name

  # =====================================
  # STABLE PRINCIPAL ASSIGNMENT
  # =====================================

  principal_id = var.keyvault_admin_object_id
}

# =====================================
# Optional Sample Secret
# Lab-safe behavior
# =====================================

resource "azurerm_key_vault_secret" "app_secret" {

  count = 0

  name = "employee-db-connection"

  value = "sample-secret-value"

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_role_assignment.kv_admin
  ]
}