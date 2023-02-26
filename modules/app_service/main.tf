
resource "azurerm_service_plan" "app-plan" {
  name                = "${var.prefix}-sp"
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = "F1"
}


resource "azurerm_linux_web_app" "app" {
  name                = "${var.prefix}-app"
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.app-plan.id

  site_config {
    application_stack {
      php_version = "8.0"
    }
    always_on = false
  }
}

resource "azurerm_app_service_source_control" "source" {
  app_id        = azurerm_linux_web_app.app.id
  use_local_git = true
}
