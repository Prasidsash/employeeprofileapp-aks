# =====================================
# FILE: terraform/infra/dev/backend.tf
# VERSION: v4-stable-remote-backend
# =====================================

terraform {

  backend "azurerm" {

    # =====================================
    # REMOTE TERRAFORM STATE
    # =====================================

    resource_group_name = "employeeprofileapp-tfstate-rg"

    storage_account_name = "empproftfstate2027"

    container_name = "tfstate"

    # =====================================
    # ENVIRONMENT STATE FILE
    # =====================================

    key = "dev.terraform.tfstate"
  }
}

# =====================================
# NOTES
# =====================================

# Authentication handled by:
#
# az login
# Azure DevOps Service Connection
# AzureCLI@2 task
#
# Simplified backend for stable infra initialization.
#
# Future upgrade path:
#
# - Azure AD backend auth
# - OIDC federation
# - Multi-environment backend automation
# - Dynamic backend discovery