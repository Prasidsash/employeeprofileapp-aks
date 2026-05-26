# =====================================
# FILE: terraform/backend/variables.tf
# VERSION: v4-enterprise-disposable-final
# =====================================

# =====================================
# ENVIRONMENT
# =====================================

variable "environment" {

  description = "Environment name"

  type = string

  default = "dev"
}

# =====================================
# RESOURCE GROUP
# =====================================

variable "resource_group_name" {

  description = "Terraform backend resource group name"

  type = string
}

# =====================================
# LOCATION
# =====================================

variable "location" {

  description = "Azure region"

  type = string
}

# =====================================
# STORAGE ACCOUNT
# =====================================

variable "storage_account_name" {

  description = "Terraform backend storage account name"

  type = string
}

# =====================================
# STORAGE CONTAINER
# =====================================

variable "container_name" {

  description = "Terraform backend container name"

  type = string
}