# =====================================
# FILE: terraform/modules/keyvault/main.tf
# VERSION: v13-enterprise-keyvault-generated-sql-credentials-final
# =====================================

# =====================================
# CURRENT AZURE CLIENT INFO
# =====================================

data "azurerm_client_config" "current" {}

# =====================================
# LOCAL VALUES
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
  # SAFE KEY VAULT NAME
  # =====================================

  generated_key_vault_name = trim(
    substr(
      "${local.key_vault_base_name}kv",
      0,
      24
    ),
    "-"
  )

  # =====================================
  # OPTIONAL CUSTOM NAME OVERRIDE
  # =====================================

  key_vault_name = (
    var.key_vault_name != null &&
    var.key_vault_name != ""
  ) ? var.key_vault_name : local.generated_key_vault_name

  # =====================================
  # SQL CONNECTION STRING
  # =====================================

  sql_connection_string = (
    var.sql_server_fqdn != null &&
    var.sql_database_name != null &&
    var.db_username != null &&
    var.db_password != null
  ) ? "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.sql_database_name};Persist Security Info=False;User ID=${var.db_username};Password=${var.db_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" : null

  # =====================================
  # STABLE ADMIN OBJECT ID
  # =====================================

  effective_admin_object_id = (
    var.keyvault_admin_object_id != null &&
    var.keyvault_admin_object_id != ""
  ) ? var.keyvault_admin_object_id : data.azurerm_client_config.current.object_id
}

# =====================================
# AZURE KEY VAULT
# =====================================

resource "azurerm_key_vault" "kv" {

  name                = local.key_vault_name

  location            = var.location

  resource_group_name = var.resource_group_name

  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  soft_delete_retention_days = var.soft_delete_retention_days

  purge_protection_enabled = var.enable_purge_protection

  rbac_authorization_enabled = true

  dynamic "network_acls" {

    for_each = var.enable_network_acls ? [1] : []

    content {

      bypass = "AzureServices"

      default_action = "Allow"
    }
  }

  lifecycle {

    ignore_changes = [
      tags
    ]
  }

  tags = merge(

    {
      environment = var.environment

      project = "employeeprofileapp"

      managed_by = "terraform"

      module = "keyvault"
    },

    var.additional_tags
  )
}

# =====================================
# KEY VAULT ADMIN RBAC
# =====================================

resource "azurerm_role_assignment" "kv_admin" {

  scope = azurerm_key_vault.kv.id

  role_definition_name = "Key Vault Administrator"

  principal_id = local.effective_admin_object_id

  lifecycle {

    ignore_changes = [
      principal_id
    ]
  }
}

# =====================================
# AKS CSI SECRET ACCESS RBAC
# =====================================

resource "azurerm_role_assignment" "aks_kv_secrets_user" {

  count = var.enable_aks_kv_rbac ? 1 : 0

  scope = azurerm_key_vault.kv.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = var.aks_kubelet_object_id

  skip_service_principal_aad_check = true

  lifecycle {

    ignore_changes = [
      principal_id
    ]
  }
}

# =====================================
# OPTIONAL WORKLOAD IDENTITY RBAC
# =====================================

resource "azurerm_role_assignment" "workload_identity_kv_secrets_user" {

  count = (
    var.enable_workload_identity_keyvault_access &&
    var.workload_identity_principal_id != null &&
    var.workload_identity_principal_id != ""
  ) ? 1 : 0

  scope = azurerm_key_vault.kv.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = var.workload_identity_principal_id

  principal_type = "ServicePrincipal"

  depends_on = [
    azurerm_key_vault.kv
  ]
}

# =====================================
# RBAC PROPAGATION WAIT
# =====================================

resource "time_sleep" "wait_for_kv_rbac" {

  depends_on = [

    azurerm_role_assignment.kv_admin,

    azurerm_role_assignment.aks_kv_secrets_user,

    azurerm_role_assignment.workload_identity_kv_secrets_user
  ]

  create_duration = "180s"
}

# =====================================
# DB USERNAME SECRET
# =====================================

resource "azurerm_key_vault_secret" "db_username" {

  count = var.enable_default_key_vault_secrets ? 1 : 0

  name = "db-username"

  value = var.db_username

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]
}

# =====================================
# DB PASSWORD SECRET
# =====================================

resource "azurerm_key_vault_secret" "db_password" {

  count = var.enable_default_key_vault_secrets ? 1 : 0

  name = "db-password"

  value = var.db_password

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]
}

# =====================================
# KEY VAULT NAME SECRET
# =====================================

resource "azurerm_key_vault_secret" "keyvault_name" {

  count = var.enable_default_key_vault_secrets ? 1 : 0

  name = "keyvault-name"

  value = local.key_vault_name

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]
}

# =====================================
# SQL SERVER NAME SECRET
# =====================================

resource "azurerm_key_vault_secret" "sql_server_name" {

  count = var.enable_default_key_vault_secrets ? 1 : 0

  name = "sql-server-name"

  value = coalesce(var.sql_server_name, "")

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]
}

# =====================================
# SQL DATABASE NAME SECRET
# =====================================

resource "azurerm_key_vault_secret" "sql_database_name" {

  count = var.enable_default_key_vault_secrets ? 1 : 0

  name = "sql-database-name"

  value = coalesce(var.sql_database_name, "")

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]
}

# =====================================
# SQL SERVER FQDN SECRET
# =====================================

resource "azurerm_key_vault_secret" "sql_server_fqdn" {

  count = var.enable_default_key_vault_secrets ? 1 : 0

  name = "sql-server-fqdn"

  value = coalesce(var.sql_server_fqdn, "")

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]
}

# =====================================
# SQL CONNECTION STRING SECRET
# =====================================

resource "azurerm_key_vault_secret" "sql_connection_string" {

  count = (
    var.enable_default_key_vault_secrets &&
    local.sql_connection_string != null
  ) ? 1 : 0

  name = "sql-connection-string"

  value = local.sql_connection_string

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]
}