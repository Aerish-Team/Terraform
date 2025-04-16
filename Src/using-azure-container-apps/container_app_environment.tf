# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment
resource "azurerm_container_app_environment" "main" {
  name                        = "${var.name_prefix}-cae"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  log_analytics_workspace_id  = var.log_analytics_workspace_id
  # infrastructure_subnet_id    = azurerm_subnet.subnet.id
  # workload_profile {
  #   name = "Consumption"
  #   workload_profile_type = "Consumption"
  # }
}