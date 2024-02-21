variable "contant_var" {
    type = string
    default = "create in "
  
}


variable "vpc" {
    type = map
    default = {
        Name = "paris_vpc"
    }
  
}


variable "zone" {
    type = list
    default = ["eu-west-3a","eu-west-3b"]
  
}