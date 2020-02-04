terraform {
  required_version = "~> 0.12.5"

  backend "s3" {
    bucket = "smarthr-staging-terraform-state"
    key    = "staging-terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  version = "~> 2.20.0"
  region  = "ap-northeast-1"
}

provider "template" {
  version = "~> 2.1.2"
}

