resource "aws_security_group" "devops-project-veera" {
  name        = "devops-project-veera-nit"
  description = "Allow TLS inbound traffic"

  

  dynamic "ingress" {
    for_each = var.dynamic-ports
    content {
      description = "Allow access to port ${ingress.key}"
      from_port   = ingress.key #here key is the port number and value is the source CIDR block
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
     
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-veera-nit"
  }
}