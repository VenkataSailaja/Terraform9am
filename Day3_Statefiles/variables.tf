variable "ami_id" {
    default = "ami-00e801948462f718a"
    description = "This is the AMI ID for the EC2 instance" #optional
}
variable "instance_type" {
    default = "t2.micro"
    }