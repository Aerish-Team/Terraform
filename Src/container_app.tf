resource "azurerm_container_app_environment" "main" {
  name                        = "${local.name_prefix}-cae"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.main.id
  # infrastructure_subnet_id    = azurerm_subnet.subnet.id
  # workload_profile {
  #   name = "Consumption"
  #   workload_profile_type = "Consumption"
  # }
}

resource "azurerm_container_app" "api" {
  name                            = "${local.name_prefix}-ca-api"
  resource_group_name             = azurerm_resource_group.main.name
  container_app_environment_id    = azurerm_container_app_environment.main.id
  revision_mode                   = "Single"

  secret {
    name  = "ghcr-pat"
    value = var.ghcr_pat
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.server.id
    ]
  }

 secret {
    identity              = azurerm_user_assigned_identity.server.id
    name                  = "ghcr-pat"
    key_vault_secret_id   = azurerm_key_vault_secret.ghcr_pat.id
  }

  template {
    container {
      name   = "${local.name_prefix}-c-api"
      image  = "${var.ghcr_url}/vgdagpin/aerish.api:${var.aerish_version}"
      cpu    = "0.5"
      memory = "1Gi"
      env {
        name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
        value = azurerm_application_insights.main.connection_string
      }
      env {
        name  = "ConnectionStrings__AerishDbContext_MSSQLConStr"
        value = "Server=${azurerm_mssql_server.main.fully_qualified_domain_name};Database=${azurerm_mssql_database.main.name};Encrypt=True;TrustServerCertificate=False;"
      }
    }

    min_replicas = 1
    max_replicas = 3
  }

  registry {
    server               = var.ghcr_url
    username             = var.ghcr_username
    password_secret_name = "ghcr-pat"
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  tags = var.tags
}
