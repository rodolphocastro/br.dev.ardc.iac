
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.104.0"
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

// terraform import azurerm_resource_group.swapi /subscriptions/76bdb027-5c55-41d3-8ac4-43e2e2717ac6/resourceGroups/swapi
// Resource group for SWAPI, add resources by changing the ./swapi-resources.tf file
resource "azurerm_resource_group" "swapi" {
  name     = "swapi"
  location = "East US 2"
  tags = {
    project     = "swapi"
    environment = "production"
  }
}
// Resource group for Gravel-Alves, add resources by changing the ./gravel-resources.tf file
resource "azurerm_resource_group" "gravel-alves" {
  name     = "gravel-alves"
  location = "East US 2"
  tags = {
    project     = "gravel-alves"
    environment = "production"
  }
}