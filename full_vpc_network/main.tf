provider "aws" {
    region = var.region
}


resource "aws_vpc" "vpc_network" {
    cidr_block = var.vpc
    tags = {
      Name = "network"
    }
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.vpc_network.id
    map_public_ip_on_launch = true
    cidr_block = "192.168.0.0/22"
    availability_zone = "eu-west-3a"
    tags = {
      Name ="subnet-1"
    }
}

resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.vpc_network.id
    cidr_block = "192.168.12.0/22"
    availability_zone = "eu-west-3b"
    tags = {
      Name ="subnet-2"
    }
}

resource "aws_route_table" "RT1" {
    vpc_id = aws_vpc.vpc_network.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.network_IGW.id

    }
    tags = {
      Name = "RT!!!!"
    }
  
}

resource "aws_route_table" "RT2" {
    vpc_id = aws_vpc.vpc_network.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.network_IGW.id

    }
    tags = {
      Name = "RT$$$$$"
    }
  
}

resource "aws_route_table_association" "RTA" {
    subnet_id = aws_subnet.subnet-1.id
    route_table_id = aws_route_table.RT1.id
  
}

resource "aws_route_table_association" "RTA1" {
    subnet_id = aws_subnet.subnet-2.id
    route_table_id = aws_route_table.RT2.id
  
}


resource "aws_internet_gateway" "network_IGW" {
    vpc_id = aws_vpc.vpc_network.id
    tags = {
      Name = "network-igw"
    }
  
}


