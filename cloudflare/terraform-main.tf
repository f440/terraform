terraform {
  backend "s3" {
    bucket   = "kufu-terraform-state"
    key      = "cloudflare/cloudflare-terraform.tfstate"
    region   = "ap-northeast-1"
    role_arn = "arn:aws:iam::736134917012:role/administrator"
  }
}

provider "cloudflare" {
  version = "~> 1.12"
}

