terraform {

  backend "azurerm" {

    resource_group_name = "employeeprofileapp-tfstate-rg"

    storage_account_name = "empproftfstate2026"

    container_name = "tfstate"

    key = "dev.terraform.tfstate"
  }
}