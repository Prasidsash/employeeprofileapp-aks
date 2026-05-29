# =====================================
# FILE: terraform/modules/sql/outputs.tf
# VERSION: v2-enterprise-keyvault-generated-sql-credentials-final
# =====================================

# =====================================
# SQL SERVER
# =====================================

output "sql_server_id" {

  description = "Azure SQL Server ID"

  value = try(
    azurerm_mssql_server.sql_server[0].id,
    null
  )
}

output "sql_server_name" {

  description = "Azure SQL Server name"

  value = try(
    azurerm_mssql_server.sql_server[0].name,
    null
  )
}

output "sql_server_fqdn" {

  description = "Azure SQL Server FQDN"

  value = try(
    azurerm_mssql_server.sql_server[0].fully_qualified_domain_name,
    null
  )
}

# =====================================
# SQL DATABASE
# =====================================

output "sql_database_id" {

  description = "Azure SQL Database ID"

  value = try(
    azurerm_mssql_database.sql_database[0].id,
    null
  )
}

output "sql_database_name" {

  description = "Azure SQL Database name"

  value = try(
    azurerm_mssql_database.sql_database[0].name,
    null
  )
}

# =====================================
# GENERATED SQL CREDENTIALS
# =====================================

output "sql_admin_username" {

  description = "Generated SQL administrator username"

  value = local.sql_admin_username
}

output "sql_admin_password" {

  description = "Generated SQL administrator password"

  value = random_password.sql_admin_password.result

  sensitive = true
}

# =====================================
# SQL CONNECTION METADATA
# =====================================

output "sql_connection_metadata" {

  description = "Azure SQL connection metadata"

  value = {

    sql_server_name = try(
      azurerm_mssql_server.sql_server[0].name,
      null
    )

    sql_server_fqdn = try(
      azurerm_mssql_server.sql_server[0].fully_qualified_domain_name,
      null
    )

    sql_database_name = try(
      azurerm_mssql_database.sql_database[0].name,
      null
    )

    sql_admin_username = local.sql_admin_username
  }

  sensitive = true
}