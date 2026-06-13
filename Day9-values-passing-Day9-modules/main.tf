module "dev" {
    source = "../Day9-modules"
    ami_id        = "ami-00e801948462f718a"
    instance_type  = "t2.medium"
    name = "dev instance"
}