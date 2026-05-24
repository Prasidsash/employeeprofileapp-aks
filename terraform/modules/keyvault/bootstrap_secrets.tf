# =====================================
# OPTIONAL BOOTSTRAP SECRETS
# =====================================

resource "azurerm_key_vault_secret" "bootstrap_secrets" {

  for_each = var.enable_bootstrap_secrets ? var.bootstrap_secrets : {}

  name = each.key

  value = each.value

  key_vault_id = azurerm_key_vault.kv.id

  content_type = "bootstrap-secret"

  tags = merge(
    {
      environment = var.environment
      managed_by  = "terraform"
      secret_type = "bootstrap"
    },
    var.additional_tags
  )

  depends_on = [
    azurerm_role_assignment.kv_admin
  ]
}