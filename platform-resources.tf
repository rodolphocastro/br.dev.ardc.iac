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

// CName that maps from blog.github.ardc.dev.br to rodolphocastro.github.io
resource "azurerm_dns_cname_record" "github-blog-ardc-dev-br" {
  name                = "blog.github"
  zone_name           = azurerm_dns_zone.ardc-dev-br-dns.name
  resource_group_name = azurerm_resource_group.platform-tools.name
  ttl                 = 300
  record              = "rodolphocastro.github.io"
  tags                = local.platform_tags
}

// TXT record for ardc.dev.br
resource "azurerm_dns_txt_record" "ardc-dev-br-entra-txt" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ardc-dev-br-dns.name
  resource_group_name = azurerm_resource_group.platform-tools.name
  ttl                 = 3600

  record {
    value = "MS=ms75122764"
  }

  tags = local.platform_tags
}