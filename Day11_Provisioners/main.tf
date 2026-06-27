#Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}
#VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}
#Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
        tags = {
            Name = "my_subnet1"
        }
    }

#Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "my_igw"
    }
}
#Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
    tags = {
        Name = "my_route_table"
    }
}
#Subnet Route Table Association
resource "aws_route_table_association""my_rt_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

#Security Group
resource "aws_security_group" "my_sg" {
  name        = "my_security_group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
#Ec2 Instance
resource "aws_instance" "my_instance" {
  ami           = "ami-00e801948462f718a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "LinuxServer"
  }
}
# connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("~/.ssh/id_ed25519")
#     host       = aws_instance.my_instance.public_ip
#     timeout     = "2m"
# }
# provisioner "file" {
#     source      = "file1"
#     destination = "/home/ec2-user/file1"
# }
# provisioner "remote-exec" {
#     inline = [
#         "sudo yum install -y nginx",
#         "sudo systemctl start nginx",
#         "sudo systemctl enable nginx"
#     ]
# }
# provisioner "remote-exec" {
#     inline = [
#         "touch /home/ec2-user/file2",
#         "echo 'Hello, I am from remote-exec provisioner' >> /home/ec2-user/file2"
#     ]
# } #Go and check in remote server cd /home/ec2-user/ as a root user, file2 is created or not and check the content of the file.
# provisioner "local-exec" {
#      command = "touch file500"
# }
# }

resource "null_resource" "run_script" {
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.my_instance.public_ip
      user        = "ec2-user"
      private_key = file("~/.ssh/id_ed25519")
    }
    # provisioner "file" {
    # source      = "file10"
    # destination = "/home/ec2-user/dev.sh" #destination path on the remote instance copy the file10 from local to remote instance with the name file10
    # }
    inline = [
      "echo 'hello from Nareshit' >> /home/ec2-user/file200",
      
        #"bash /home/ec2-user/dev.sh" # Assuming test.sh is already on the instance 
    ]
  }
  triggers = {
    always_run = "${timestamp()}" # This will ensure the provisioner runs every time you apply, as the timestamp will always change.
  }
#   triggers = {
#   script_hash = filemd5("dev.sh") # Rerun only if script changes
# }
}

#Solution-2 to Re-Run the Provisioner
#Use terraform taint to manually mark the resource for recreation:
# terraform taint aws_instance.server
# terraform apply

     



