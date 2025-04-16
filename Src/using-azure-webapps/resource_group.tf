resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg-using-webapps"
  location = "Southeast Asia"
}