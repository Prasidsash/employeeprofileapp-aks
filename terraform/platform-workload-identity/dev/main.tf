terraform {

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "infra" {

  backend = "azurerm"

  config = {

    resource_group_name  = "employeeprofileapp-tfstate-rg"

    storage_account_name = "employeeprofileapptfstate"

    container_name       = "tfstate"

    key                  = "dev-infra.tfstate"
  }
}

module "federated_identity" {

  source = "../../modules/federated_identity"

  resource_group_name = data.terraform_remote_state.infra.outputs.resource_group_name

  namespace = data.terraform_remote_state.infra.outputs.namespace_name

  service_account_name = data.terraform_remote_state.infra.outputs.service_account_name

  identity_name = data.terraform_remote_state.infra.outputs.workload_identity_name

  identity_resource_group_name = data.terraform_remote_state.infra.outputs.resource_group_name

  user_assigned_identity_id = data.terraform_remote_state.infra.outputs.workload_identity_id

  oidc_issuer_url = data.terraform_remote_state.infra.outputs.aks_oidc_issuer_url
}