# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity
# terraform import azurerm_user_assigned_identity.server /subscriptions/27de852c-c023-4de6-ac4d-52c9d4470482/resourceGroups/teeledger-q-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/teeledger-q-ua-server
resource "azurerm_user_assigned_identity" "server" {
  name                = "${local.name_prefix}-ua-server"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}