# resource "aws_instance" "nameinst" {
#     ami = "ami-00e801948462f718a"
#     instance_type = "t2.micro"
#     #count = 3
#     count = length(var.env)

#     tags = {
#       Name = var.env[count.index]
#     }
# }

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my-subnet" {
    vpc_id            = aws_vpc.my-vpc.id
    cidr_block        = var.cidrs[count.index]
    count = length(var.subnets)
    tags = {
        Name = var.subnets[count.index]
    }
}