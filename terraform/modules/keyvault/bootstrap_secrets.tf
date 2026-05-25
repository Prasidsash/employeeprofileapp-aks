# =====================================
# OPTIONAL BOOTSTRAP KEY VAULT SECRETS
# =====================================

resource "azurerm_key_vault_secret" "bootstrap_secrets" {

  for_each = var.enable_bootstrap_secrets ? var.bootstrap_secrets : {}

  name = each.key

  value = each.value

  key_vault_id = azurerm_key_vault.kv.id
}