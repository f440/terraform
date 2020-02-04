terraform {
  required_version = "~> 0.12.5"

  backend "s3" {
    bucket   = "kufu-terraform-state"
    key      = "production-terraform.tfstate"
    region   = "ap-northeast-1"
    role_arn = "arn:aws:iam::736134917012:role/administrator"
  }
}

provider "aws" {
  version = "~> 2.20.0"
  region  = "ap-northeast-1"

  assume_role {
    role_arn = "arn:aws:iam::736134917012:role/administrator"
  }
}

provider "template" {
  version = "~> 2.1.2"
}

