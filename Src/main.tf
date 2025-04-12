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
  name_prefix = "${var.services_prefix}-${var.env_name}"
}

data "azurerm_client_config" "current" {}

module "container" {
  source                                  = "./container"

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


/*
resource "azurerm_key_vault" "main" {
  name                = "${local.name_prefix}-kv"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "standard"
  tenant_id           = var.tenant_id
}

resource "azurerm_key_vault_access_policy" "user" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_key_vault_access_policy" "app" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = var.app_object_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_key_vault_secret" "ghcr_username" {
  name         = "ghcr-username"
  value        = var.ghcr_username
  key_vault_id = azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "ghcr_pat" {
  name         = "ghcr-pat"
  value        = var.ghcr_pat
  key_vault_id = azurerm_key_vault.main.id
}
*/

# resource "azurerm_virtual_network" "vnet" {
#   name               = "${local.name_prefix}-vnet"
#   location            = azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name
#   address_space       = ["10.0.0.0/16"]
# }

# resource "azurerm_subnet" "subnet" {
#   name                 = "${local.name_prefix}-subnet"
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.0.0/16"]
#   delegation {
#     name = "ContainerApp-Delegation"
#     service_delegation {
#       name    = "Microsoft.App/environments"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action"
#       ]
#     }
#   }
# }



# resource "azurerm_container_app" "reports" {
#   name                              = "${local.name_prefix}-ca-reports"
#   resource_group_name               = azurerm_resource_group.main.name
#   container_app_environment_id      = azurerm_container_app_environment.main.id
#   revision_mode                     = "Single"

#   secret {
#     name  = "ghcr-pat"
#     value = var.ghcr_pat
#   }

#   template {
#     container {
#       name   = "${local.name_prefix}-c-reports"
#       image  = "${var.ghcr_url}/vgdagpin/aerish.reports:${var.aerish_version}"
#       cpu    = "0.5"
#       memory = "1Gi"
#       env {
#         name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
#         value = azurerm_application_insights.main.connection_string
#       }
#     }

#     min_replicas = 1
#     max_replicas = 3
#   }

#   registry {
#     server               = var.ghcr_url
#     username             = var.ghcr_username
#     password_secret_name = "ghcr-pat"
#   }

#   ingress {
#     external_enabled = true
#     target_port      = 8080
#     traffic_weight {
#       latest_revision = true
#       percentage      = 100
#     }
#   }

#   tags = var.tags
# }

# resource "azurerm_container_app" "admin" {
#   name                            = "${local.name_prefix}-ca-admin"
#   resource_group_name             = azurerm_resource_group.main.name
#   container_app_environment_id    = azurerm_container_app_environment.main.id
#   revision_mode                   = "Single"

#   secret {
#     name  = "ghcr-pat"
#     value = var.ghcr_pat
#   }

#   template {
#     container {
#       name   = "${local.name_prefix}-c-admin"
#       image  = "${var.ghcr_url}/vgdagpin/aerish.admin:${var.aerish_version}"
#       cpu    = "0.5"
#       memory = "1Gi"
#       env {
#         name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
#         value = azurerm_application_insights.main.connection_string
#       }
#     }

#     min_replicas = 1
#     max_replicas = 3
#   }

#   registry {
#     server               = var.ghcr_url
#     username             = var.ghcr_username
#     password_secret_name = "ghcr-pat"
#   }

#   ingress {
#     external_enabled = true
#     target_port      = 8080
#     traffic_weight {
#       latest_revision = true
#       percentage      = 100
#     }
#   }

#   tags = var.tags
# }

# resource "azurerm_container_app" "eportal" {
#   name                            = "${local.name_prefix}-ca-eportal"
#   resource_group_name             = azurerm_resource_group.main.name
#   container_app_environment_id    = azurerm_container_app_environment.main.id
#   revision_mode                   = "Single"

#   secret {
#     name  = "ghcr-pat"
#     value = var.ghcr_pat
#   }

#   template {
#     container {
#       name   = "${local.name_prefix}-c-eportal"
#       image  = "${var.ghcr_url}/vgdagpin/aerish.eportal:${var.aerish_version}"
#       cpu    = "0.5"
#       memory = "1Gi"
#       env {
#         name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
#         value = azurerm_application_insights.main.connection_string
#       }
#     }

#     min_replicas = 1
#     max_replicas = 3
#   }

#   registry {
#     server               = var.ghcr_url
#     username             = var.ghcr_username
#     password_secret_name = "ghcr-pat"
#   }

#   ingress {
#     external_enabled = true
#     target_port      = 8080
#     traffic_weight {
#       latest_revision = true
#       percentage      = 100
#     }
#   }

#   tags = var.tags
# }