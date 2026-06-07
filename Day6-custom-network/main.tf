resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "Custom_VPC"
    }
}
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.0/26"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Subnet1"
    }
}
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.64/26"
    availability_zone = "us-east-1b"
    tags = {
        Name = "Subnet2"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "Custom_IGW"
    }
}
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "Custom_RT"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.rt.id
}
# Creating an Elastic IP for the NAT Gateway
resource "aws_eip" "nateip" {
    domain = "vpc"
    tags = {
        Name = "Custom_EIP"
    }
}
# Creating a NAT Gateway in the second subnet 
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nateip.id
    subnet_id = aws_subnet.subnet2.id
    tags = {
        Name = "Custom_NAT"
    }
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "Private_RT"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
}
resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.private_rt.id
}
resource "aws_security_group" "sg" {
    name = "Custom_SG"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        ingress {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "Custom_EC2"
    }
}