provider "aws" {
    region = "eu-west-3"

}


resource "aws_vpc" "ssvpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name ="security_vpc"
  }
}

resource "aws_default_security_group" "ssgroup" {
  vpc_id = aws_vpc.ssvpc.id

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 443
    to_port   = 443
    cidr_blocks = [ "0.0.0.0/0" ]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security group"
  }
}