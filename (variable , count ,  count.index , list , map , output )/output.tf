output "subnet_ip" {
    value = aws_subnet.name_subnet_32[*].cidr_block
  
}