variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "aks_cluster_id" {
  type = string
}

variable "aks_cluster_name" {
  type = string
}

variable "backup_vault_name" {
  type = string
}

variable "backup_storage_account_name" {
  type = string
}

variable "backup_container_name" {
  type = string
}

variable "backup_policy_name" {
  type = string
}

variable "backup_schedule_repeating_time_intervals" {
  type = list(string)
}

variable "backup_retention_duration_count" {
  type = number
}

variable "backup_retention_duration_type" {
  type = string
}

variable "additional_tags" {
  type = map(string)

  default = {}
}