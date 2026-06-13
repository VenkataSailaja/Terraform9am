module "test" {
    source = "../Day9-modules"
    ami_id        = "ami-00e801948462f718a"
    instance_type  = "t2.micro" 
    name = "test instance"
}