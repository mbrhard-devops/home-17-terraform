variable "cloud_id" { type = string }
variable "folder_id" { type = string }
variable "token" { type = string sensitive = true }
variable "ssh_public_key" { type = string sensitive = true }
variable "ssh_user" { type = string default = "ubuntu" }
variable "zone" { type = string default = "ru-central1-a" }
variable "vpc_name" { type = string default = "final-project-vpc" }
variable "subnet_cidr" { type = list(string) default = ["10.0.1.0/24"] }
variable "vm_name" { type = string default = "final-project" }
variable "vm_cores" { type = number default = 2 }
variable "vm_memory" { type = number default = 2 }
variable "vm_disk_size" { type = number default = 20 }
variable "vm_image_family" { type = string default = "ubuntu-2204-lts" }
variable "db_password" { type = string sensitive = true }
variable "db_user" { type = string default = "app_user" }
variable "db_name" { type = string default = "app_db" }
variable "db_host" { type = string default = "temp-host" }
variable "registry_id" { type = string default = "temp-registry" }

variable "web_ingress_rules" {
  type = list(object({
    port        = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
  default = [
    { port = 22, protocol = "TCP", description = "SSH", cidr_blocks = ["0.0.0.0/0"] },
    { port = 80, protocol = "TCP", description = "HTTP", cidr_blocks = ["0.0.0.0/0"] },
    { port = 443, protocol = "TCP", description = "HTTPS", cidr_blocks = ["0.0.0.0/0"] }
  ]
}

variable "db_ingress_rules" {
  type = list(object({
    port        = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
  default = [
    { port = 3306, protocol = "TCP", description = "MySQL from app subnet", cidr_blocks = ["10.0.1.0/24"] }
  ]
}
