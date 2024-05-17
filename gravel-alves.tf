// Resources belonging to the gravel-alves resource group

// tags for all resources within the gravel-alves group
locals {
  gravel_tags = {
    environment = "platform"
    project     = "gravel-alves"
  }
}

// an azure storage account with static website enabled
resource "azurerm_storage_account" "gravel-alves-storage" {
  name                     = "gravelalvesstorage"
  resource_group_name      = azurerm_resource_group.gravel-alves.name
  location                 = azurerm_resource_group.gravel-alves.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.gravel_tags

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}