terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "iam/tf"
    region = "ap-northeast-1"
  }
}
