# resource "aws_instance" "name" {
#     ami           = "ami-00e801948462f718a"
#     instance_type = "t2.micro"
#     count = var.dev ? 1 : 0
    #if dev is true then create 1 instance if false then create 0 instance
    #true 1
    #false 0
# }

# resource "aws_s3_bucket" "mys3bucket" {
#     bucket = "bvconfiguresssdbiuj"
# }


resource "aws_instance" "example" {
  count         = var.env == "prod" ? 3 : 1
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.micro"

  tags = {
    Name = "example-${count.index}"
  }
}

# #In this case:
# #If var.env == "prod" → count = 3
# #Else (like dev, qa, etc.) → count = 1
# #terraform apply -var="env=dev"