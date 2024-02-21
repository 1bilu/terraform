provider "aws" {
    region = var.region
}

resource "aws_vpc" "new_vpc" {
    cidr_block = var.cidr_block

    tags = {
      Name = "new_vpc"
    }
  
}