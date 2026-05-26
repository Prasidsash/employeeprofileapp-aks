# =====================================
# FILE: terraform/modules/keyvault/main.tf
# VERSION: v7-enterprise-disposable-stable
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
  # ENTERPRISE DEFAULT SECRETS
  # =====================================

  default_key_vault_secrets = {

    db-username = var.db_username

    db-password = var.db_password

    keyvault-name = local.key_vault_name
  }

  # =====================================
  # ENTERPRISE ADMIN OBJECT ID
  # =====================================

  effective_admin_object_id = coalesce(

    var.keyvault_admin_object_id,

    data.azurerm_client_config.current.object_id
  )
}

# =====================================
# AZURE KEY VAULT
# =====================================

resource "azurerm_key_vault" "kv" {

  name = local.key_vault_name

  location = var.location

  resource_group_name = var.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  # =====================================
  # LAB / NON-PROD SETTINGS
  # =====================================

  soft_delete_retention_days = var.soft_delete_retention_days

  purge_protection_enabled = var.enable_purge_protection

  # =====================================
  # RBAC AUTHORIZATION
  # =====================================

  rbac_authorization_enabled = true

  # =====================================
  # OPTIONAL NETWORK ACLS
  # =====================================

  dynamic "network_acls" {

    for_each = var.enable_network_acls ? [1] : []

    content {

      bypass = "AzureServices"

      default_action = "Allow"
    }
  }

  # =====================================
  # LIFECYCLE
  # =====================================

  lifecycle {

    ignore_changes = [
      tags
    ]
  }

  # =====================================
  # TAGS
  # =====================================

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
}

# =====================================
# OPTIONAL WORKLOAD IDENTITY RBAC
# =====================================

resource "azurerm_role_assignment" "workload_identity_kv_secrets_user" {

  count = var.enable_workload_identity_keyvault_access ? 1 : 0

  scope = azurerm_key_vault.kv.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = var.workload_identity_principal_id

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

  for_each = var.enable_default_key_vault_secrets ? local.default_key_vault_secrets : {}

  name = each.key

  value = each.value

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