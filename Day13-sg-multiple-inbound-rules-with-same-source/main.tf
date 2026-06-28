resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
}

resource "aws_subnet" "my-subnet" {
    vpc_id            = aws_vpc.my-vpc.id
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "my-subnet"
    }       
}
resource "aws_security_group" "my-sg" {
    name        = "MySG"
    description = "My security group"
    vpc_id      = aws_vpc.my-vpc.id

    ingress = [
        for port in var.ports : {
            description = "Allow port ${port}"
            from_port   = port
            to_port     = port
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            security_groups = []
            self = false
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "my-instance" {
    ami           = "ami-00e801948462f718a"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.my-subnet.id
    vpc_security_group_ids = [aws_security_group.my-sg.id]
    tags = {
        Name = "Sginstance"
    }
}