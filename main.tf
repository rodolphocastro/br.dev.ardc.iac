
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }

  # terraform state files on Azure, this needs to be created manually in Azure Portal
  backend "azurerm" {
    resource_group_name  = "platform-tools"
    storage_account_name = "ardcterraformstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# making AzureRM data available to other terraform entries
data "azurerm_client_config" "current" {
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
