resource "yandex_mdb_mysql_cluster" "app_db" {
  name        = "${var.vm_name}-mysql"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.app_network.id

  version = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_size          = 20
    disk_type_id       = "network-ssd"
  }

  user {
    name     = var.db_user
    password = var.db_password

    permission {
      database_name = var.db_name
      roles         = ["ALL"]
    }
  }

  database {
    name = var.db_name
  }

  host {
    name      = "mysql-host"
    zone      = var.zone
    subnet_id = yandex_vpc_subnet.app_subnet.id
  }

  security_group_ids = [yandex_vpc_security_group.db_sg.id]
}

output "db_host" {
  description = "MySQL host FQDN"
  value       = yandex_mdb_mysql_cluster.app_db.host[0].fqdn
}