resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "My_VPC"
    }
}
resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Subnet1"
    }
}
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "Subnet3"
    }
}

