# =====================================
# FILE: terraform/modules/federated_identity/main.tf
# VERSION: v2-enterprise-disposable-final
# =====================================

resource "azurerm_federated_identity_credential" "workload_identity" {

  name = "${var.identity_name}-fic"

  resource_group_name = var.identity_resource_group_name

  parent_id = var.user_assigned_identity_id

  audience = [

    "api://AzureADTokenExchange"
  ]

  issuer = trimsuffix(
    var.oidc_issuer_url,
    "/"
  )

  subject = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
}