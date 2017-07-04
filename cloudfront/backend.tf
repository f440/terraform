terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "cf/tf"
    region = "ap-northeast-1"
  }
}
