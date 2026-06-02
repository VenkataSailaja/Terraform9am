output "instance_publicIP" {
    value = aws_instance.my_server.public_ip
    description = "This is the public IP of my server" #optional
  
}

output "instance_pvtIP" {
    value = aws_instance.my_server.private_ip
}

output "instance_zone" {
    value = aws_instance.my_server.availability_zone
}

output "instance_subnetIP" {
    value = aws_instance.my_server.subnet_id
}

output "bucket" {
    value = aws_s3_bucket.s3.bucket
    
}