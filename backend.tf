terraform {
  backend "s3" {
    bucket = "kufu-terraform-state"
    key    = "tf"
    region = "ap-northeast-1"
  }
}
