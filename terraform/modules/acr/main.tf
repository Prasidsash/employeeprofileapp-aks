# =====================================
# FILE: terraform/modules/acr/main.tf
# VERSION: v5-enterprise-disposable-final
# =====================================

resource "azurerm_container_registry" "acr" {

  name = var.acr_name

  resource_group_name = var.resource_group_name

  location = var.location

  sku = var.acr_sku

  admin_enabled = false

  public_network_access_enabled = true

  anonymous_pull_enabled = false

  network_rule_bypass_option = "AzureServices"

  tags = merge(

    {
      environment = var.environment

      managed_by = "terraform"

      project = "employeeprofileapp"

      module = "acr"
    },

    var.additional_tags
  )
}