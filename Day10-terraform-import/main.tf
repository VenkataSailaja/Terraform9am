resource "aws_instance" "name" {
    ami           = "ami-0521cb2d60cfbb1a6"
    instance_type = "t2.micro"
    tags = {
        Name = "SRE server"
    }
  
}

resource "aws_s3_bucket" "name" {
    bucket = "sresailajasaisuppi"
}
resource "aws_s3_bucket_versioning" "name" {
    bucket = aws_s3_bucket.name.id
    versioning_configuration {
        status = "Suspended"
    }
}


#terraform import aws_instance.name i-0b1c2d3e4f5g6h7i
#terraform import aws_s3_bucket.name my-terraform-import-bucket