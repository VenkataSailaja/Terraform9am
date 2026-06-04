terraform {
  backend "s3" {
    bucket = "sbdidgfjff"
    key = "test/terraform.tfstate"
    use_lockfile = true
    region = "us-east-1"
  }
}
  