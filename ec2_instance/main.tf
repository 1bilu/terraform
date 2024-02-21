provider "aws" {
    region = "eu-west-3"
}

resource "aws_instance" "insta_1" {
    ami = "ami-009d5fce35d17d28c"
    instance_type = "t2.micro"
    key_name = "paris"
    tags = {
      Name="instance_terraformapply"
    }
}