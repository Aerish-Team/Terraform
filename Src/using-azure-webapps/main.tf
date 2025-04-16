provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  use_cli = true
  subscription_id = var.subscription_id
}

locals {
  name_prefix = "${var.services_prefix}-${var.env_name}-wa"
}

data "azurerm_client_config" "current" {}

module "azure-webapps" {
  source                                  = "./webapps"

  name_prefix                            =  local.name_prefix
  resource_group_name                     = azurerm_resource_group.main.name
  resource_group_location                 = azurerm_resource_group.main.location
  log_analytics_workspace_id              = azurerm_log_analytics_workspace.main.id
  server_shared_identity_id               = azurerm_user_assigned_identity.server.id
  keyvault_db_connection_string_id        = azurerm_key_vault_secret.dbconnectionstring.id
  keyvault_ghcr_path_id                   = azurerm_key_vault_secret.ghcr_pat.id
  application_insights_connection_string  = azurerm_application_insights.main.connection_string
  ghcr_url                                = var.ghcr_url
  ghcr_username                           = var.ghcr_username
  aerish_version_api                      = var.aerish_version_api
  aerish_version_admin                    = var.aerish_version_admin
  aerish_version_reports                    = var.aerish_version_reports
  aerish_version_eportal                    = var.aerish_version_eportal
  tags                                    = var.tags
}