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
