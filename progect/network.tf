# VPC network
resource "yandex_vpc_network" "app_network" {
  name = var.vpc_name
}

# Subnet
resource "yandex_vpc_subnet" "app_subnet" {
  name           = "${var.vpc_name}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.app_network.id
  v4_cidr_blocks = var.subnet_cidr
}

# Web security group (dynamic rules)
resource "yandex_vpc_security_group" "web_sg" {
  name        = "${var.vpc_name}-web-sg"
  description = "Security group for web app"
  network_id  = yandex_vpc_network.app_network.id

  dynamic "ingress" {
    for_each = var.web_ingress_rules
    content {
      protocol       = ingress.value.protocol
      port           = ingress.value.port
      v4_cidr_blocks = ingress.value.cidr_blocks
      description    = ingress.value.description
    }
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow all outbound traffic"
  }
}

# DB security group (dynamic rules)
resource "yandex_vpc_security_group" "db_sg" {
  name        = "${var.vpc_name}-db-sg"
  description = "Security group for Managed MySQL"
  network_id  = yandex_vpc_network.app_network.id

  dynamic "ingress" {
    for_each = var.db_ingress_rules
    content {
      protocol       = ingress.value.protocol
      port           = ingress.value.port
      v4_cidr_blocks = ingress.value.cidr_blocks
      description    = ingress.value.description
    }
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow all outbound traffic"
  }
}