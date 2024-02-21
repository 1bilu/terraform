variable "vpc" {
  type    = string
  default = "10.0.0.0/20"

}

variable "tag" {
  type    = string
  default = "sg_vpc"

}

variable "mess" {
    type = string
    default = "in the "
  
}





variable "subnet_tag" {
  type    = string
  default = "sg_vpc_subnet"

}
variable "availability_zone" {
  type    = list
  default = ["eu-west-3a", "eu-west-3b"]

}
