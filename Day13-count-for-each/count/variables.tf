# variable "env" {
#    type = list(string)
#    default = [ "dev", "prod" ] 
# }
variable "subnets" {
   type = list(string)
   default = [ "subnet1", "subnet2" ] 
}

variable "cidrs" {
   type = list(string)
   default = ["10.0.0.0/24","10.0.1.0/24"]
}