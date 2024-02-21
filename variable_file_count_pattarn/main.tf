provider "aws" {
    region = var.region
  
}


resource "aws_instance" "var_insta" {
    count = 2
    ami = var.ami
    key_name = var.key_name
    instance_type = var.insta
    availability_zone = var.availability
    tags = {
      Name = "var_insta"
    }
  
}


