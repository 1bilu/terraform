provider "aws" {
    region = var.region
  
}
resource "aws_vpc" "vpc_security" {
    cidr_block = var.vpc
    tags = {
      Name = "vpc_security"
    }
  
}

resource "aws_security_group" "sgroup" {
    name = "security"
    description = "create a sgroup"
    vpc_id = aws_vpc.vpc_security.id
    tags = {
      Name="sssss"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.sgroup.id
  cidr_ipv4         = aws_vpc.vpc_security.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sgroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
