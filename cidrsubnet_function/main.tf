provider "aws" {
    region = "eu-west-3"
  
}


resource "aws_vpc" "name_vpc21" {
    cidr_block = "10.0.0.0/20"         #prefix value
    tags = {
      Name = "name_vpc2112"
    }
  
}


resource "aws_subnet" "name_subnet_32" {
    count = 4
    cidr_block = cidrsubnet(aws_vpc.name_vpc21.cidr_block, 4 , 3)     #cidrsubnet(prefix, newbits, netnum)
    vpc_id = aws_vpc.name_vpc21.id
    map_public_ip_on_launch = true
  
}

resource "aws_instance" "name_instagram" {
    ami = "ami-009d5fce35d17d28c"
    key_name = "paris"
    # availability_zone = "eu-west-3a"
    instance_type = "t2.micro"
    tags = {
      Name = "instagram"
    }
  
}
