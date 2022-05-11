terraform {
  required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">= 2.0"
      }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

variable "appName" { default = "mmc511"}
variable "env" { default = "tf" }

resource "azurerm_resource_group" "rg" {
  name = "bnk-${var.appName}-${var.env}-rg"
  location = "centralus"
}

resource "azurerm_app_service_plan" "myPlan" {
  name = "${var.appName}-${var.env}-plan"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind = "Linux"
  reserved = true
  sku {
      tier = "Standard"
      size = "S1"
  }
}

resource "azurerm_app_service" "myApp" {
  name = "${var.appName}-${var.env}-site"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.myPlan.id
  site_config {
    linux_fx_version = "DOTNETCORE|6.0"
    app_command_line = "dotnet myApp.dll"
  }
}

output "siteName" { value = azurerm_app_service.myApp.name }
output "rgName" { value = azurerm_resource_group.rg.name }
