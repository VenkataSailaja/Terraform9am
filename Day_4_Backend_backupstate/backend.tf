terraform {
  backend "s3" {
    bucket = "yeficuahvbljsdn"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}