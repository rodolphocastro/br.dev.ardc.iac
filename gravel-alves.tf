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

// CName that maps from gravel-alves.com.br to the static web app host-name
resource "azurerm_dns_cname_record" "gravel-alves-com-br" {
  name                = "www"
  zone_name           = azurerm_dns_zone.gravel-alves-com-br-dns.name
  resource_group_name = azurerm_resource_group.platform-tools.name
  ttl                 = 300
  record              = azurerm_static_web_app.gravel-alves.default_host_name
  tags                = local.platform_tags
}

# setting up the custom domain for the static web app
resource "azurerm_static_web_app_custom_domain" "gravel-alves" {
  static_web_app_id = azurerm_static_web_app.gravel-alves.id
  domain_name       = "${azurerm_dns_cname_record.gravel-alves-com-br.name}.${azurerm_dns_cname_record.gravel-alves-com-br.zone_name}"
  validation_type   = "cname-delegation"
}