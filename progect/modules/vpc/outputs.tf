output "network_id" {
  description = "VPC network ID"
  value       = yandex_vpc_network.main.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = yandex_vpc_subnet.main.id
}

output "web_sg_id" {
  description = "Web security group ID"
  value       = yandex_vpc_security_group.web_sg.id
}

output "db_sg_id" {
  description = "DB security group ID"
  value       = yandex_vpc_security_group.db_sg.id
}
