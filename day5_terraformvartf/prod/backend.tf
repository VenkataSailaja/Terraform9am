terraform {
  backend "s3" {
    bucket = "sbdidgfjff"
    key = "prod/terraform.tfstate"
    use_lockfile = true
    region = "us-east-1"
  }
}
  