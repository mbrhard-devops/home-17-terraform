terraform {
  required_version = ">= 1.5"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "mbrhard-tf-state-05-1776752950"
    region = "us-east-1"
    key    = "final-project/terraform.tfstate"

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