module "s3_bucket" {
  source = "github.com/VenkataSailaja/terraform-aws-s3-bucket.git"

  buckett = var.buckett
  acl    = var.acl
  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership

  versioning = {
    enabled = var.versioning["enabled"]
  }
}