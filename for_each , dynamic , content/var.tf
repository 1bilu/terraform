variable "vpc" {
  type    = string
  default = "10.0.0.0/20"

}

variable "vpc_tag" {
  type    = string
  default = "SG_vpc"

}


variable "security" {
  type    = string
  default = "SG_security_group"

}