terraform {

  backend "azurerm" {

    # =====================================
    # Remote Terraform State
    # =====================================

    resource_group_name = "employeeprofileapp-tfstate-rg"

    storage_account_name = "empproftfstate2026"

    container_name = "tfstate"

    # =====================================
    # Environment-Specific State File
    # =====================================

    key = "prod.terraform.tfstate"
  }
}

# =====================================
# OPTIONAL FUTURE BACKEND NOTES
# =====================================

# Future enterprise enhancements may include:
#
# - Separate backend per environment
# - Dedicated subscription for state storage
# - State access policies
# - Terraform Cloud migration
# - State replication / DR strategy
#
# Current backend model intentionally
# preserves stable remote state behavior.