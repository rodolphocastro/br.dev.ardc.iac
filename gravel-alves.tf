// Resources belonging to the gravel-alves resource group

// tags for all resources within the gravel-alves group
locals {
  gravel_tags = {
    environment = "platform"
    project     = "gravel-alves"
  }
}

// an Azure Static Web App for the Gravel-Alves project, in the free tier and East US 2 region
resource "azurerm_static_web_app" "gravel-alves" {
  name                = "gravel-alves"
  resource_group_name = azurerm_resource_group.gravel-alves.name
  location            = azurerm_resource_group.gravel-alves.location
  tags                = local.gravel_tags
}