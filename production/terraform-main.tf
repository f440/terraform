terraform {
  # TODO : 後々HCL2系の0.12にアップデート
  # required_version = "~> 0.12.5"
  required_version = "~> 0.11.13"

  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "production-terraform.tfstate"
    region = "ap-northeast-1"
    # TODO : IAM Roleベースで適用する際に利用する
    # role_arn = "arn:aws:iam::ACCOUNT_ID:role/terraform"
  }
}

provider "aws" {
  # TODO: 後々2.x系にアップデートを実施する
  # version = "~> 2.20.0"
  version = "~> 1.60.0"
  region  = "ap-northeast-1"
}

provider "template" {
  version = "~> 2.1.2"
}
