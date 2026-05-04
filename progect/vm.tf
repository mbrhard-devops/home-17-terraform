data "yandex_compute_image" "ubuntu" {
  family    = var.vm_image_family
  folder_id = "standard-images"
}

locals {
  cloud_init_config = templatefile("${path.module}/templates/cloud-init.yaml.tftpl", {
    ssh_user       = var.ssh_user
    ssh_public_key = var.ssh_public_key
    db_host        = var.db_host
    db_user        = var.db_user
    db_password    = var.db_password
    db_name        = var.db_name
    registry_id    = var.registry_id
  })
}

resource "yandex_compute_instance" "app" {
  name        = "${var.vm_name}-vm"
  description = "VM for web application with Docker"
  hostname    = var.vm_name
  zone        = var.zone
  
  platform_id = "standard-v3"
  
  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }
  
  scheduling_policy {
    preemptible = true
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      name     = "${var.vm_name}-boot-disk"
      type     = "network-ssd"
      size     = var.vm_disk_size
    }
  }
  
  network_interface {
    subnet_id          = yandex_vpc_subnet.app_subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }
  
  metadata = {
    user-data = local.cloud_init_config
    ssh-keys  = "${var.ssh_user}:${var.ssh_public_key}"
  }
}

output "vm_public_ip" {
  value = yandex_compute_instance.app.network_interface[0].nat_ip_address
}

output "vm_internal_ip" {
  value = yandex_compute_instance.app.network_interface[0].ip_address
}