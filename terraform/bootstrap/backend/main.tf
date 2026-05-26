# =====================================
# FILE: terraform/backend/main.tf
# VERSION: v6-enterprise-bootstrap-final-stable
# =====================================

# =====================================
# LOCAL VALUES
# =====================================

locals {

  common_tags = {

    environment = var.environment

    project = "employeeprofileapp"

    managed_by = "terraform"

    module = "backend"
  }
}

# =====================================
# TERRAFORM STATE RESOURCE GROUP
# =====================================

resource "azurerm_resource_group" "tfstate" {

  name = var.resource_group_name

  location = var.location

  tags = local.common_tags
}

# =====================================
# TERRAFORM STATE STORAGE ACCOUNT
# =====================================

resource "azurerm_storage_account" "tfstate" {

  name = lower(var.storage_account_name)

  resource_group_name = azurerm_resource_group.tfstate.name

  location = azurerm_resource_group.tfstate.location

  account_tier = "Standard"

  account_replication_type = "LRS"

  account_kind = "StorageV2"

  min_tls_version = "TLS1_2"

  allow_nested_items_to_be_public = false

  shared_access_key_enabled = true

  public_network_access_enabled = true

  infrastructure_encryption_enabled = false

  blob_properties {

    versioning_enabled = true
  }

  lifecycle {

    ignore_changes = [
      tags
    ]
  }

  tags = local.common_tags
}

# =====================================
# TERRAFORM STATE CONTAINER
# =====================================

resource "azurerm_storage_container" "tfstate" {

  name = var.container_name

  storage_account_id = azurerm_storage_account.tfstate.id

  container_access_type = "private"
}

# =====================================
# BACKEND RBAC ACCESS
# =====================================

resource "azurerm_role_assignment" "tfstate_blob_contributor" {

  scope = azurerm_storage_account.tfstate.id

  role_definition_name = "Storage Blob Data Contributor"

  principal_id = data.azurerm_client_config.current.object_id

}