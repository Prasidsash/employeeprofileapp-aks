# =====================================
# FILE: terraform/modules/sql/main.tf
# VERSION: v2-enterprise-keyvault-generated-sql-credentials-final
# =====================================

# =====================================
# LOCAL VALUES
# =====================================

locals {

  common_tags = merge(

    {
      environment = var.environment

      project = "employeeprofileapp"

      managed_by = "terraform"

      module = "sql"
    },

    var.additional_tags
  )

  sql_admin_username = "sqladmin"
}

# =====================================
# GENERATED SQL ADMIN PASSWORD
# =====================================

resource "random_password" "sql_admin_password" {

  length = 32

  special = true
}

# =====================================
# AZURE SQL SERVER
# =====================================

resource "azurerm_mssql_server" "sql_server" {

  count = var.enable_sql_database ? 1 : 0

  name = var.sql_server_name

  resource_group_name = var.resource_group_name

  location = var.location

  version = var.sql_server_version

  administrator_login = local.sql_admin_username

  administrator_login_password = random_password.sql_admin_password.result

  public_network_access_enabled = var.enable_sql_public_network_access

  minimum_tls_version = "1.2"

  tags = local.common_tags
}

# =====================================
# AZURE SQL DATABASE
# =====================================

resource "azurerm_mssql_database" "sql_database" {

  count = var.enable_sql_database ? 1 : 0

  name = var.sql_database_name

  server_id = azurerm_mssql_server.sql_server[0].id

  sku_name = var.sql_database_sku_name

  max_size_gb = var.sql_max_size_gb

  zone_redundant = false

  lifecycle {

    prevent_destroy = false
  }

  tags = local.common_tags
}

# =====================================
# SQL FIREWALL RULES
# =====================================

resource "azurerm_mssql_firewall_rule" "sql_firewall_rules" {

  for_each = (
    var.enable_sql_database &&
    var.enable_sql_firewall_rules
  ) ? {

    for rule in var.sql_firewall_rules :

    rule.name => rule
  } : {}

  name = each.value.name

  server_id = azurerm_mssql_server.sql_server[0].id

  start_ip_address = each.value.start_ip_address

  end_ip_address = each.value.end_ip_address
}