# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
# terraform import azurerm_mssql_server.main /subscriptions/27de852c-c023-4de6-ac4d-52c9d4470482/resourceGroups/teeledger-q-rg/providers/Microsoft.Sql/servers/teeledger-q-db-server
resource "azurerm_mssql_server" "main" {
  name                         = "${local.name_prefix}-db-server"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.database_admin_password
  tags                         = var.tags
  # primary_user_assigned_identity_id = azurerm_user_assigned_identity.server.id
  azuread_administrator {
    login_username = azurerm_user_assigned_identity.server.name
    object_id      = azurerm_user_assigned_identity.server.principal_id
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database
# terraform import azurerm_mssql_database.main /subscriptions/27de852c-c023-4de6-ac4d-52c9d4470482/resourceGroups/teeledger-q-rg/providers/Microsoft.Sql/servers/teeledger-q-db-server/databases/teeledger-q-db
resource "azurerm_mssql_database" "main" {
  name                = "${local.name_prefix}-db"
  server_id           = azurerm_mssql_server.main.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  sku_name            = "Basic"
  max_size_gb         = 1
  read_scale          = false
  zone_redundant      = false
  tags                = var.tags

  # prevent the possibility of accidental data loss when running terraform destroy
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name                = "AllowAzureServices"
  server_id           = azurerm_mssql_server.main.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}