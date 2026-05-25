# =====================================
# Current Azure Client Info
# =====================================

data "azurerm_client_config" "current" {}

# =====================================
# Terraform State Resource Group
# =====================================

resource "azurerm_resource_group" "tfstate" {

  name = var.resource_group_name

  location = var.location
}

# =====================================
# Terraform State Storage Account
# =====================================

resource "azurerm_storage_account" "tfstate" {

  name = var.storage_account_name

  resource_group_name = azurerm_resource_group.tfstate.name

  location = azurerm_resource_group.tfstate.location

  account_tier = "Standard"

  account_replication_type = "LRS"

  account_kind = "StorageV2"
}

# =====================================
# Terraform State Container
# =====================================

resource "azurerm_storage_container" "tfstate" {

  name = var.container_name

  storage_account_id = azurerm_storage_account.tfstate.id

  container_access_type = "private"
}

# =====================================
# Backend RBAC Access
# =====================================

resource "azurerm_role_assignment" "tfstate_blob_contributor" {

  scope = azurerm_storage_account.tfstate.id

  role_definition_name = "Storage Blob Data Contributor"

  principal_id = var.azure_devops_sp_object_id
}