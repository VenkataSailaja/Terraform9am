resource "aws_instance" "prod" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
      Name = var.name
    }
}
