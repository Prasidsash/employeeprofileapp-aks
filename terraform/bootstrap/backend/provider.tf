# =====================================
# FILE: terraform/backend/provider.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

terraform {

  required_version = ">= 1.5.0"

  required_providers {

    azurerm = {

      source = "hashicorp/azurerm"

      version = "~> 4.0"
    }
  }
}

# =====================================
# CURRENT AZURE CLIENT INFO
# =====================================

data "azurerm_client_config" "current" {}

# =====================================
# AZURE PROVIDER
# ENTERPRISE OIDC AUTHENTICATION
# =====================================

provider "azurerm" {

  features {

    resource_group {

      prevent_deletion_if_contains_resources = false
    }
  }

  use_oidc = true

  use_cli = false

  storage_use_azuread = true
}