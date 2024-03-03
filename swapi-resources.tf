// tags for all resources within the platform-tools group
locals {
  swapi_tags = {
    environment = "production"
    project     = "swapi"
  }
}

// terraform import azurerm_app_service_plan.swapi-asp /subscriptions/76bdb027-5c55-41d3-8ac4-43e2e2717ac6/resourceGroups/swapi/providers/Microsoft.Web/serverFarms/ASP-swapi-97a8
# resource "azurerm_app_service_plan" "swapi-asp" {
#   name                = "ASP-swapi-97a8"
#   location            = azurerm_resource_group.swapi.location
#   resource_group_name = azurerm_resource_group.swapi.name
#   kind                = "Linux"
#   reserved            = true
#   sku {
#     tier = "Free"
#     size = "F1"
#   }
#   tags = local.swapi_tags
# }

// terraform import azurerm_app_service.swapi_deno /subscriptions/76bdb027-5c55-41d3-8ac4-43e2e2717ac6/resourceGroups/swapi/providers/Microsoft.Web/sites/swapi-deno
# resource "azurerm_app_service" "swapi_deno" {
#   name                = "swapi-deno"
#   location            = azurerm_resource_group.swapi.location
#   resource_group_name = azurerm_resource_group.swapi.name
#   app_service_plan_id = "/subscriptions/76bdb027-5c55-41d3-8ac4-43e2e2717ac6/resourceGroups/swapi/providers/Microsoft.Web/serverfarms/ASP-swapi-97a8"
#   https_only          = true

#   site_config {
#     default_documents = [
#       "Default.htm",
#       "Default.html",
#       "Default.asp",
#       "index.htm",
#       "index.html",
#       "iisstart.htm",
#       "default.aspx",
#       "index.php",
#       "hostingstart.html",
#     ]
#     linux_fx_version = "DOCKER|rodolphoalves/swapi-deno:latest"
#   }

#   app_settings = {
#     "DOCKER_ENABLE_CI"                    = "true"
#     "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
#     "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
#   }

#   tags = local.swapi_tags
# }
