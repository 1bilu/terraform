provider "aws" {
    region = "eu-west-3"
  
}

resource "aws_vpc" "name_vpc21" {
    cidr_block = "10.0.0.0/20"         #prefix value
    tags = {
      Name = var.vpc["Name"]           # call variable by use maping and use indexing    here Name is index
    }
  
}


resource "aws_subnet" "name_subnet_32" {
    count = 2
    cidr_block = cidrsubnet(aws_vpc.name_vpc21.cidr_block, 4 , count.index+1)     #cidrsubnet(prefix, newbits, netnum)
    vpc_id = aws_vpc.name_vpc21.id
    availability_zone = var.zone[count.index]
    map_public_ip_on_launch = true
    tags = {
      Name = "subnet ${count.index} ${var.contant_var} ${var.zone[count.index]}"        /*here call count.index --> subnet 0 ,subnet 1  ,subnet 1 
      => and var.contant is variable only use for what we want to write contant       and => var.zone is define which one zone is create */
    }
  
}

resource "aws_instance" "name_instagram" {
    count = 2
    ami = "ami-009d5fce35d17d28c"
    key_name = "paris"
    availability_zone = var.zone[count.index]      /* here is call a variable that work fetching the value one by one in the list  (list is create in var.tf file)*/
    instance_type = "t2.micro"
    tags = {
      Name = "instagram ${count.index +1}"       /*here count.index -->  work is change the tag name only link i have instagram use index[0,1,2,3] 
                                              the name is instagram 0 ,instagram 1 etc.       and +1 --> is increment of index value [1,2,3,4] */
    }
  
}
 