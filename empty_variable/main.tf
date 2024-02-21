provider "aws" {
    region = var.region
  
}

resource "aws_vpc" "name_vpc" {
    cidr_block = var.cidr_block
    tags = {
      Name = "vpcpcpc"
    }
  
}
