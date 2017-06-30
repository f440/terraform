terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "s3/tf"
    region = "ap-northeast-1"
  }
}
