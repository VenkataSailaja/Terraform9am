resource "aws_instance" "my_server" {
    ami = var.ami_id
    instance_type = var.instance_type
     tags = {
       Name = "Terraform-Managed-EC2"
     }
}

resource "aws_s3_bucket" "s3" {
    bucket = var.bucket_name
    
}