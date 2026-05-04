resource "yandex_container_registry" "app_registry" {
  name      = "${var.vm_name}-registry"
  folder_id = var.folder_id
}

output "registry_id" {
  value = yandex_container_registry.app_registry.id
}
