output "db_host" {
  value = yandex_mdb_mysql_cluster.app_db.host[0].fqdn
}

output "vm_public_ip" {
  value = yandex_compute_instance.app.network_interface[0].nat_ip_address
}

output "registry_id" {
  value = yandex_container_registry.app_registry.id
}
