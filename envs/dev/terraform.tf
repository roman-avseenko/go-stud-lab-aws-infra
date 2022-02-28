# terraform config
terraform {
  required_version = "~> 1.1.0"
  required_providers {
    aws    = "~> 4.2.0"
    random = "~> 3.1.0"
  }
}

provider "aws" {
  region  = "eu-north-1"
  profile = "itechart"
}
