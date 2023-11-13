terraform {
  required_providers {
    aws = "~> 5.2"
  }
}

provider "aws" {
  region = var.region
}
