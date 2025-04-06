output "DB_Connection_String" {
  value = "Server=${azurerm_mssql_server.main.fully_qualified_domain_name};Database=${azurerm_mssql_database.main.name};Encrypt=True;TrustServerCertificate=False;User Id=${azurerm_mssql_server.main.administrator_login};Password={database_admin_password};"
}

output "ApiUrl" {
  value = azurerm_container_app.api.ingress.fqdn
}
