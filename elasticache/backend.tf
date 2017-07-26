terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "elasticache/tf"
    region = "ap-northeast-1"
  }
}
