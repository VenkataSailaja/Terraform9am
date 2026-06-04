resource "aws_instance" "name" {
    ami = "ami-00e801948462f718a"
    instance_type = "t2.micro"
    tags = {
      Name ="Myserver"
    }
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags={
        Name = "MY-VPC"
    }
<<<<<<< Updated upstream
  
}
resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags ={
        Name = "Subnet1"
    }
}
=======

}
resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags ={
        Name = "Subnet2"
    }
}
>>>>>>> Stashed changes
