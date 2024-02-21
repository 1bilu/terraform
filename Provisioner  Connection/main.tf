provider "aws" {
  region = var.region

}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/20"
  tags = {
    Name = "test_vpc"
  }

}

resource "aws_subnet" "test_sub" {
  count             = 1
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.0.0/22"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true
  tags = {
    Name = "test_sub"
  }

}

resource "aws_default_route_table" "test_RT" {
  default_route_table_id = aws_vpc.test_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "test_RT"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "test_igw"
  }

}

resource "aws_default_security_group" "ssgroup" {
  vpc_id = aws_vpc.test_vpc.id

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 22
    to_port   = 22
    cidr_blocks = [ "0.0.0.0/0" ]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_security_group"
  }
}

resource "aws_instance" "test_instance" {
  count                  = 1
  ami                    = "ami-009d5fce35d17d28c"
  instance_type          = "t2.micro"
  key_name               = "paris"
  vpc_security_group_ids = [aws_default_security_group.ssgroup.id]
  subnet_id              = aws_subnet.test_sub[count.index].id
  tags = {
    Name = "test_instance"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./paris.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "sudo yum install -y httpd",
               "sudo systemctl start httpd",
               "sudo systemctl enable httpd",
            ]
    
  }
  provisioner "file" {
    source      = "D:/terraform code/CODES/Provisioner  Connection/index.html"
    destination = "sudo /var/www/html/index.html"

  } 



}