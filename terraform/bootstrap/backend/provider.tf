# =====================================
# FILE: terraform/backend/provider.tf
# VERSION: v6-final-fixed-auth-stable
# =====================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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
# FIXED: Azure DevOps compatible authentication
# =====================================

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  # IMPORTANT:
  # DO NOT use use_oidc or CLI flags here in Azure DevOps pipelines
  # Authentication is handled by AzureCLI@2 + service connection + ARM env vars
}