// Resources belonging to the platform-tools resource group

// tags for all resources within the platform-tools group
locals {
  platform_tags = {
    environment = "platform"
  }
}

// DNS Zone for ardc.dev.br
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

// DNS Zone for gravel-alves.com.br
resource "azurerm_dns_zone" "gravel-alves-com-br-dns" {
  name                = "gravel-alves.com.br"
  resource_group_name = azurerm_resource_group.platform-tools.name
  tags                = local.platform_tags
}

// CName that maps from gravel-alves.com.br to https://gravelalvesstorage.z20.web.core.windows.net/
resource "azurerm_dns_cname_record" "gravel-alves-com-br" {
  name                = "@"
  zone_name           = azurerm_dns_zone.gravel-alves-com-br-dns.name
  resource_group_name = azurerm_resource_group.platform-tools.name
  ttl                 = 300
  record              = "gravelalvesstorage.z20.web.core.windows.net"
  tags                = local.platform_tags
}

// KeyVault for secrets
resource "azurerm_key_vault" "terraform-vault" {
  name                      = "terraformVault${random_string.vaultSpice.result}"
  enable_rbac_authorization = true
  location                  = azurerm_resource_group.platform-tools.location
  resource_group_name       = azurerm_resource_group.platform-tools.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  purge_protection_enabled  = false
  tags                      = local.platform_tags
}

// A random string for vault name
resource "random_string" "vaultSpice" {
  length  = 8
  special = false
  upper   = false
}

// Declaring an output
output "keyvault-sample-output" {
  value     = azurerm_key_vault.terraform-vault.id
  sensitive = true
}

// Uploading the output to the Azure Key Vault
resource "azurerm_key_vault_secret" "terraform-vault-id" {
  name         = "terraformVaultId"
  value        = azurerm_key_vault.terraform-vault.id
  key_vault_id = azurerm_key_vault.terraform-vault.id
}