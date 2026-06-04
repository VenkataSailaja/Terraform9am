terraform {
  backend "s3" {
    bucket = "sbdidgfjff"
    key = "terraform.tfstate"
    use_lockfile = true
    region = "us-east-1"
  }
}