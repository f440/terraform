terraform {
  required_version = "~> 0.11.13"

  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "terraform"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  version = "~> 2.19.0"
  region  = "ap-northeast-1"
  profile = "smarthr-development"
}

provider "template" {
  version = "~> 2.1.2"
}
