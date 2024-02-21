output "pub_ip" {
    value = aws_instance.var_insta.public_ip
  
}

output "pub_dns" {
    value = aws_instance.var_insta.public_dns
  
}
output "pri" {
    value = aws_instance.var_insta.private_ip
  
}