output "backup_vault_id" {

  value = azurerm_data_protection_backup_vault.backup.id
}

output "backup_vault_name" {

  value = azurerm_data_protection_backup_vault.backup.name
}

output "backup_policy_id" {

  value = azurerm_data_protection_backup_policy_kubernetes_cluster.backup.id
}

output "backup_instance_id" {

  value = null
}

output "backup_storage_account_name" {

  value = azurerm_storage_account.backup.name
}