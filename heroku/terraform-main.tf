terraform {
  required_version = "~> 0.12.0"

  backend "s3" {
    bucket   = "kufu-terraform-state"
    key      = "heroku/heroku-terraform.tfstate"
    region   = "ap-northeast-1"
    role_arn = "arn:aws:iam::736134917012:role/administrator"
  }
}

provider "heroku" {
  version = "~> 2.1.0"
  email   = var.heroku_email
  api_key = var.heroku_api_key
}

