terraform {

  backend "azurerm" {

    # =====================================
    # Remote Terraform State
    # =====================================

    resource_group_name  = "employeeprofileapp-tfstate-rg"

    storage_account_name = "empproftfstate2027"

    container_name       = "tfstate"

    # =====================================
    # Environment-Specific State File
    # =====================================

    key                  = "dev.terraform.tfstate"

    # =====================================
    # Azure AD Authentication
    # =====================================

    use_azuread_auth     = true
  }
}