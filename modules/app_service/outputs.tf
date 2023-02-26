locals {
  scm_username = azurerm_linux_web_app.app.site_credential.0.name
  scm_password = azurerm_linux_web_app.app.site_credential.0.password
  repo_uri     = replace(azurerm_app_service_source_control.source.repo_url, "https://", "")
}

output "repository_url" {
  value = "https://${local.scm_username}:${local.scm_password}@${local.repo_uri}/${azurerm_linux_web_app.app.name}.git"
}

output "app_name" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "id" {
  value = azurerm_linux_web_app.app.id
}
