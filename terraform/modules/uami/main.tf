# =====================================
# FILE: terraform/modules/uami/main.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

resource "azurerm_user_assigned_identity" "uami" {

  name = var.identity_name

  resource_group_name = var.resource_group_name

  location = var.location

  tags = merge(

    {
      environment = var.environment

      managed_by = "terraform"

      project = "employeeprofileapp"

      module = "uami"
    },

    var.additional_tags
  )
}