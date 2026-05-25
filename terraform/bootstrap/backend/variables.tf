variable "resource_group_name" {

  type = string
}

variable "location" {

  type = string
}

variable "storage_account_name" {

  type = string
}

variable "container_name" {

  type = string
}

# =====================================
# Azure DevOps Service Principal
# =====================================

variable "azure_devops_sp_object_id" {

  description = "Azure DevOps Service Principal Object ID"

  type = string
}