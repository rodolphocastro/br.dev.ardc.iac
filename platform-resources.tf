// Resources belonging to the platform-tools resource group

// tags for all resources within the platform-tools group
locals {
  platform_tags = {
    environment = "platform"
  }
}

// DNS Zone
resource "azurerm_dns_zone" "ardc-dev-br-dns" {
  name                = "ardc.dev.br"
  resource_group_name = azurerm_resource_group.platform-tools.name
  tags                = local.platform_tags
}

// CName that maps from rodolphocastro.github.io to github.ardc.dev.br
// TODO: validate after DNS changes on registro.br are live
resource "azurerm_dns_cname_record" "github-ardc-dev-br" {
  name                = "github.ardc.dev.br"
  zone_name           = azurerm_dns_zone.ardc-dev-br-dns.name
  resource_group_name = azurerm_resource_group.platform-tools.name
  ttl                 = 300
  record              = "rodolphocastro.github.io"
}