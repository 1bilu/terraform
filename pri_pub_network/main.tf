provider "aws" {
    region = "eu-west-3"
  
}


resource "aws_vpc" "name_vpc" {
    cidr_block = "192.168.0.0/20"

    tags = {
        Name = "Name_vpc"
    }
  
}

resource "aws_subnet" "pub_sub" {
    cidr_block = "192.168.0.0/22"
    vpc_id = aws_vpc.name_vpc.id
    map_public_ip_on_launch = true
    availability_zone = "eu-west-3a"
    tags = {
      Name = "pub_sub"
    }
  
}

resource "aws_subnet" "pri_sub" {
    cidr_block = "192.168.12.0/22"
    vpc_id = aws_vpc.name_vpc.id
    availability_zone = "eu-west-3b"
    tags = {
      Name = "pri_sub"
    }
  
}

resource "aws_route_table" "routnig_table_pub" {
    vpc_id = aws_vpc.name_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW_21.id
    }
    tags = {
      Name = "RT_PUB"
    }
    
  
}

resource "aws_route_table" "routnig_table_pri" {
    vpc_id = aws_vpc.name_vpc.id
    tags = {
      Name = "RT_pri"
    }
}


resource "aws_route_table_association" "pub_rta" {
    subnet_id = aws_subnet.pub_sub.id
    route_table_id = aws_route_table.routnig_table_pub.id
  
}

resource "aws_route_table_association" "pri_rta" {
    subnet_id = aws_subnet.pri_sub.id
    route_table_id = aws_route_table.routnig_table_pri.id
  
}


resource "aws_internet_gateway" "IGW_21" {
  vpc_id = aws_vpc.name_vpc.id
  tags = {
    Name = "IGW_new"
  }
}

resource "aws_security_group" "aws_security" {
    vpc_id = aws_vpc.name_vpc.id


    ingress {
        self = true
        from_port = 22
        to_port = 22
        cidr_blocks = [ "0.0.0.0/0"]
        protocol = "tcp"
        description = "allow port"

    }


    egress {
        cidr_blocks = [ "0.0.0.0/0"]
        from_port = "0"
        to_port = "0"
        protocol = "-1"
    }


    tags = {
      Name = "secu_group"
    }
  
}



resource "aws_instance" "pub_insta" {
    instance_type = "t2.micro"
    key_name = "paris"
    ami =  "ami-009d5fce35d17d28c"
    vpc_security_group_ids = [aws_security_group.aws_security.id]
    subnet_id = aws_subnet.pub_sub.id
    tags = {
      Name = "pub_insta"
    }
  
}

resource "aws_instance" "pri_insta" {
    instance_type = "t2.micro"
    key_name = "paris"
    ami =  "ami-009d5fce35d17d28c"
    vpc_security_group_ids = [aws_security_group.aws_security.id]
    subnet_id = aws_subnet.pri_sub.id
    tags = {
      Name = "pri_insta"
    }
  
}