provider "aws" {
  region = "eu-west-3"
}


resource "aws_vpc" "sg_vpc" {
  cidr_block = var.vpc
  tags = {
    Name = var.vpc_tag
  }

}


resource "aws_security_group" "SG_group" {
  name        = ""
  vpc_id      = aws_vpc.sg_vpc.id
  description = "create a security group"


  dynamic "ingress" {
    for_each = ["22", "80", "443", "8080", "4243"]
    iterator = bilu

    content {
      description = "allow_tcp"
      protocol    = "tcp"
      from_port   = bilu.value
      to_port     = bilu.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    protocol    = "-1"
    from_port   = "0"
    to_port     = "0"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = var.security
  }


} 



