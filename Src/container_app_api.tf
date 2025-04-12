# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app
resource "azurerm_container_app" "api" {
  name                            = "${local.name_prefix}-ca-api"
  resource_group_name             = azurerm_resource_group.main.name
  container_app_environment_id    = azurerm_container_app_environment.main.id
  revision_mode                   = "Single"
  max_inactive_revisions          = 0
  tags = var.tags

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

  secret {
    identity              = azurerm_user_assigned_identity.server.id
    name                  = "db-connection-string"
    key_vault_secret_id   = azurerm_key_vault_secret.dbconnectionstring.id
  }

  template {
    container {
      name   = "${local.name_prefix}-c-api"
      image  = "${var.ghcr_url}/vgdagpin/aerish.api:${var.aerish_version_api}"
      cpu    = "0.5"
      memory = "1Gi"
      env {
        name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
        value = azurerm_application_insights.main.connection_string
      }
      env {
        name = "ConnectionStrings__AerishDbContext_MSSQLConStr"
        secret_name = "db-connection-string"
      }
    }

    min_replicas = 0
    max_replicas = 3
  }

  registry {
    server               = var.ghcr_url
    username             = var.ghcr_username
    password_secret_name = "ghcr-pat"
  }

  ingress {
    external_enabled = true
    target_port      = 17000
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

output "Api_fqdn" {
  value = azurerm_container_app.api.ingress[0].fqdn
}



# resource "time_sleep" "wait_20_seconds" {
#   create_duration = "20s"
#   depends_on = [
#     cloudflare_record.api_TXT
#   ]
# }

# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_custom_domain
# resource "azurerm_container_app_custom_domain" "custom_domain" {
#   name                 = "${cloudflare_record.api_cname.name}.${var.domain_name}"
#   container_app_id     = azurerm_container_app.api.id
#   certificate_binding_type = "SniEnabled"

#   depends_on = [
#     time_sleep.wait_20_seconds
#   ]

#   lifecycle {
#     ignore_changes = [
#       certificate_binding_type
#     ]
#   }
# }