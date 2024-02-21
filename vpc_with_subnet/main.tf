
provider "aws" {
    region = "eu-west-3"
}

resource "aws_vpc" "new_vpc" {
    cidr_block = var.vpc

    tags = {
      Name = " vpc_terraform"
    }
  
}

resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.new_vpc.id
    cidr_block = var.subnet

    tags = {
      Name = "sub1"
    }
  
}


resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.new_vpc.id
    cidr_block = var.subnet2

    tags = {
      Name = " sub2"
    }
  
}