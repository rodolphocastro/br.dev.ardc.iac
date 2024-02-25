
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

// Platform Resource group, add resources by changing the ./platform-tools/resources.tf file
resource "azurerm_resource_group" "platform-tools" {
  name     = "platform-tools"
  location = "East US"
  tags = {
    environment = "platform"
  }
}