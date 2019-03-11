terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "cloudflare/tf"
    region = "ap-northeast-1"
  }
}
