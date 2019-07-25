terraform {
  required_version = "~> 0.12.5"

  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "production-terraform.tfstate"
    region = "ap-northeast-1"
    # TODO : IAM Roleベースで適用する際に利用する
    # role_arn = "arn:aws:iam::ACCOUNT_ID:role/terraform"
  }
}

provider "aws" {
  version = "~> 2.20.0"
  region  = "ap-northeast-1"
}

provider "template" {
  version = "~> 2.1.2"
}
