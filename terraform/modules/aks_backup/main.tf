# =====================================
# STORAGE ACCOUNT
# =====================================

resource "azurerm_storage_account" "backup" {

  name = var.backup_storage_account_name

  resource_group_name = var.resource_group_name

  location = var.location

  account_tier = "Standard"

  account_replication_type = "LRS"

  account_kind = "StorageV2"

  tags = merge(
    {
      environment = var.environment
      managed_by  = "terraform"
      workload    = "aks-backup"
    },
    var.additional_tags
  )
}

# =====================================
# STORAGE CONTAINER
# =====================================

resource "azurerm_storage_container" "backup" {

  name = var.backup_container_name

  storage_account_id = azurerm_storage_account.backup.id

  container_access_type = "private"
}

# =====================================
# BACKUP VAULT
# =====================================

resource "azurerm_data_protection_backup_vault" "backup" {

  name = var.backup_vault_name

  resource_group_name = var.resource_group_name

  location = var.location

  datastore_type = "VaultStore"

  redundancy = "LocallyRedundant"

  tags = merge(
    {
      environment = var.environment
      managed_by  = "terraform"
      workload    = "aks-backup"
    },
    var.additional_tags
  )
}

# =====================================
# BACKUP POLICY
# =====================================

resource "azurerm_data_protection_backup_policy_kubernetes_cluster" "backup" {

  name = var.backup_policy_name

  resource_group_name = var.resource_group_name

  vault_name = azurerm_data_protection_backup_vault.backup.name

  backup_repeating_time_intervals = var.backup_schedule_repeating_time_intervals

  default_retention_rule {

    life_cycle {

      duration = "P${var.backup_retention_duration_count}${var.backup_retention_duration_type}"

      data_store_type = "OperationalStore"
    }
  }
}

# =====================================
# AKS BACKUP INSTANCE
# =====================================

# resource "azurerm_data_protection_backup_instance_kubernetes_cluster" "backup" {
#
#   name = "${var.aks_cluster_name}-backup-instance"
#
#   location = var.location
#
#   vault_id = azurerm_data_protection_backup_vault.backup.id
#
#   kubernetes_cluster_id = var.aks_cluster_id
#
#   snapshot_resource_group_name = "${var.resource_group_name}-backup-snapshot-rg"
#
#   backup_policy_id = azurerm_data_protection_backup_policy_kubernetes_cluster.backup.id
#
#   depends_on = [
#     azurerm_storage_container.backup,
#     azurerm_data_protection_backup_policy_kubernetes_cluster.backup
#   ]
# }