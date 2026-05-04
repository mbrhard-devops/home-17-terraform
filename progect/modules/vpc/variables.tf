variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "subnet"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "web_ingress_rules" {
  description = "Ingress rules for web security group"
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
  description = "Ingress rules for database security group"
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
