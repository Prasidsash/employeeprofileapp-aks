# =====================================
# FILE: terraform/infra/dev/backend.tf
# VERSION: v2-enterprise-disposable-foundation
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
    # ENVIRONMENT-SPECIFIC STATE FILE
    # =====================================

    key = "dev.terraform.tfstate"

    # =====================================
    # ENTERPRISE AZURE AD AUTHENTICATION
    # =====================================

    use_azuread_auth = true

    # =====================================
    # ENTERPRISE OIDC AUTHENTICATION
    # =====================================

    use_oidc = true
  }
}

# =====================================
# ENTERPRISE BACKEND NOTES
# =====================================

# Recommended Azure DevOps variables:
#
# ARM_USE_OIDC=true
# ARM_USE_AZUREAD=true
# ARM_CLIENT_ID=<federated-app-client-id>
# ARM_TENANT_ID=<tenant-id>
# ARM_SUBSCRIPTION_ID=<subscription-id>
#
# Enterprise disposable environment benefits:
#
# - No storage account access keys
# - No backend secrets
# - Federated authentication ready
# - Safer destroy/recreate operations
# - Better RBAC enforcement
# - Pipeline identity consistency
# - Reduced stale credential risk
#
# Future phases:
#
# - Dynamic backend bootstrap
# - Backend RBAC validation
# - State locking validation
# - Stale principal cleanup
# - Backend health verification