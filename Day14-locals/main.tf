locals {
  region   = var.region
  instance_type = "t2.micro"
  ami_id= "ami-02dfbd4ff395f2a1b"
}

resource "aws_instance" "name" {
  ami = local.ami_id
  instance_type = local.instance_type
  region = local.region
}