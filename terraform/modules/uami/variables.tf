# =====================================
# FILE: terraform/modules/uami/variables.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

variable "identity_name" {

  description = "User Assigned Managed Identity name"

  type = string
}

variable "resource_group_name" {

  description = "Azure Resource Group name"

  type = string
}

variable "location" {

  description = "Azure region"

  type = string
}

variable "environment" {

  description = "Environment name"

  type = string
}

variable "additional_tags" {

  description = "Additional resource tags"

  type = map(string)

  default = {}
}