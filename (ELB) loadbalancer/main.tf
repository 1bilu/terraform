provider "aws" {
  region = "eu-west-3"

}


resource "aws_vpc" "SG_vpc" {
  cidr_block = var.vpc
  tags = {
    Name = var.tag
  }

}

resource "aws_subnet" "subnets" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.SG_vpc.cidr_block, 4, count.index)
  vpc_id            = aws_vpc.SG_vpc.id
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "${var.subnet_tag} ${count.index} ${var.mess} ${var.availability_zone[count.index]}"
  }

}



resource "aws_default_route_table" "example" {
  default_route_table_id = aws_vpc.SG_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "degault_routing"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.SG_vpc.id
  tags = {
    Name = "igw_lb"
  }
}


resource "aws_security_group" "SG_group" {
  name   = "one_sg"
  vpc_id = aws_vpc.SG_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    protocol    = "-1"
    from_port   = "0"
    to_port     = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "instances" {
  count             = 2
  ami               = "ami-009d5fce35d17d28c"
  availability_zone = var.availability_zone[count.index]
  instance_type     = "t2.micro"
  key_name          = "paris"
  tags = {
    Name = "insta ${count.index}"
  }

}



resource "aws_lb_target_group" "tg" {
  name     = "elb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.SG_vpc.id
  tags = {
    Name = "TF-target_group"
  }
}



resource "aws_lb" "loadblance" {
  name               = ""
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG_group.id]
  subnets            = [for subnet in aws_subnet.subnets : subnet.id]

  tags = {
    Name = "load"
  }

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.loadblance.arn
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
