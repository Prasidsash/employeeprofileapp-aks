# =====================================
# FILE: terraform/modules/sql/outputs.tf
# VERSION: v1-enterprise-sql-phase1-final
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
  }

  sensitive = true
}