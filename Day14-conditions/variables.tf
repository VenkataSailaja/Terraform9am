# variable "dev" {
#     type = bool
#     default = true
# }

# variable "aws_region" {
#     type = string
#     default = "us-west-2" #here we need to define either us-west-1 or eu-west-2 if i give other region will get error
#     nullable = false
#     validation {
#         condition = var.aws_region == "us-east-1" || var.aws_region == "eu-west-1"
#         error_message = "The variable 'aws_region' must be one of the following regions: us-east-1, eu-west-1"
#     }
# }

#Example-3
variable "env" {
  type    = string
  default = "prod"
}
