resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = "Southeast Asia"
}