variable "buckett" {
    type = string
    default = ""
}
variable "acl" {
    type = string
    default = ""
}
variable "control_object_ownership" {
    type = bool
    default = false
}
variable "object_ownership" {
    type = string
    default = ""
}
variable "versioning" {
    type = map(any)
    default = {
        enabled = true
    }
}