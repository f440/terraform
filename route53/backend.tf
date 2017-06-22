terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "route53/tf"
    region = "ap-northeast-1"
  }
}
