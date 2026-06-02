resource "aws_instance" "my_server" {
    ami = var.ami_id
    instance_type = var.instance_type
     tags = {
       Name = "Terraform-EC2instance"
     }
}