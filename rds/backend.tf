terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "rds/tf"
    region = "ap-northeast-1"
  }
}