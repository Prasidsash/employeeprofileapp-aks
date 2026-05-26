# =====================================
# FILE: terraform/backend/outputs.tf
# VERSION: v4-enterprise-disposable-final
# =====================================

# =====================================
# RESOURCE GROUP
# =====================================

output "resource_group_name" {

  description = "Terraform backend resource group name"

  value = azurerm_resource_group.tfstate.name
}

output "resource_group_id" {

  description = "Terraform backend resource group ID"

  value = azurerm_resource_group.tfstate.id
}

# =====================================
# STORAGE ACCOUNT
# =====================================

output "storage_account_name" {

  description = "Terraform backend storage account name"

  value = azurerm_storage_account.tfstate.name
}

output "storage_account_id" {

  description = "Terraform backend storage account ID"

  value = azurerm_storage_account.tfstate.id
}

output "primary_blob_endpoint" {

  description = "Terraform backend blob endpoint"

  value = azurerm_storage_account.tfstate.primary_blob_endpoint
}

# =====================================
# STORAGE CONTAINER
# =====================================

output "container_name" {

  description = "Terraform backend container name"

  value = azurerm_storage_container.tfstate.name
}

# =====================================
# BACKEND CONFIGURATION
# =====================================

output "backend_configuration" {

  description = "Terraform backend configuration"

  value = {

    resource_group_name  = azurerm_resource_group.tfstate.name

    storage_account_name = azurerm_storage_account.tfstate.name

    container_name       = azurerm_storage_container.tfstate.name
  }
}