# =====================================
# FILE: terraform/modules/keyvault/main.tf
# VERSION: v12-enterprise-null-safe-final
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
  # NON-SENSITIVE SECRET METADATA
  # =====================================

  secret_metadata = {

    "db-username" = true

    "db-password" = true

    "keyvault-name" = true

    "sql-server-name" = true

    "sql-database-name" = true

    "sql-server-fqdn" = true

    "sql-connection-string" = true
  }

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

  skip_service_principal_aad_check = true

  lifecycle {

    create_before_destroy = true

    ignore_changes = [
      principal_id
    ]
  }
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
# DEFAULT KEY VAULT SECRETS
# =====================================

resource "azurerm_key_vault_secret" "default_secrets" {

  for_each = var.enable_default_key_vault_secrets ? local.secret_metadata : {}

  name = each.key

  value = (
    each.key == "db-username" ? var.db_username :

    each.key == "db-password" ? var.db_password :

    each.key == "keyvault-name" ? local.key_vault_name :

    each.key == "sql-server-name" ? (
      var.sql_server_name != null ? var.sql_server_name : ""
    ) :

    each.key == "sql-database-name" ? (
      var.sql_database_name != null ? var.sql_database_name : ""
    ) :

    each.key == "sql-server-fqdn" ? (
      var.sql_server_fqdn != null ? var.sql_server_fqdn : ""
    ) :

    each.key == "sql-connection-string" ? (
      local.sql_connection_string != null ? local.sql_connection_string : ""
    ) :

    ""
  )

  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    time_sleep.wait_for_kv_rbac
  ]

  lifecycle {

    ignore_changes = [
      value
    ]
  }
}