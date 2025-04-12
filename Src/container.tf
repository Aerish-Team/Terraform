# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment
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