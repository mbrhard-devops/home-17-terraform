terraform {
  required_version = ">= 1.5"
  
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "your-bucket-name"
    region = "us-east-1"
    key    = "final-project/terraform.tfstate"
    access_key = "your-access-key"
    secret_key = "your-secret-key"
    
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/your-ydb-id"
    dynamodb_table    = "terraform_locks"
  }
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.108"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}