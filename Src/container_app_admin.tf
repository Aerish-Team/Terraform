# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app
# resource "azurerm_container_app" "admin" {
#   name                            = "${local.name_prefix}-ca-admin"
#   resource_group_name             = azurerm_resource_group.main.name
#   container_app_environment_id    = azurerm_container_app_environment.main.id
#   revision_mode                   = "Single"
#   max_inactive_revisions          = 0
#   tags = var.tags

#   identity {
#     type = "UserAssigned"
#     identity_ids = [
#       azurerm_user_assigned_identity.server.id
#     ]
#   }

#   secret {
#     identity              = azurerm_user_assigned_identity.server.id
#     name                  = "ghcr-pat"
#     key_vault_secret_id   = azurerm_key_vault_secret.ghcr_pat.id
#   }

#   template {
#     container {
#       name   = "${local.name_prefix}-c-admin"
#       image  = "${var.ghcr_url}/vgdagpin/aerish.admin:${var.aerish_version_admin}"
#       cpu    = "0.5"
#       memory = "1Gi"
#       env {
#         name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
#         value = azurerm_application_insights.main.connection_string
#       }
#     }

#     min_replicas = 0
#     max_replicas = 3
#   }

#   registry {
#     server               = var.ghcr_url
#     username             = var.ghcr_username
#     password_secret_name = "ghcr-pat"
#   }

#   ingress {
#     external_enabled = true
#     target_port      = 15000
#     traffic_weight {
#       latest_revision = true
#       percentage      = 100
#     }
#   }
# }

# output "Admin_fqdn" {
#   value = azurerm_container_app.admin.ingress[0].fqdn
# }


