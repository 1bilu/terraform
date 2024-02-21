output "inbound_rule" {
  value = aws_security_group.SG_group.ingress[*]

} # if we want to only all details like from_port to_port protocol etc. to use [*]


output "inbound_to_port" {
  value = aws_security_group.SG_group.ingress[*].to_port

} # if we want to only ports to use .to_port


output "inbound_from_port" {
  value = aws_security_group.SG_group.ingress[*].to_port

} # if we want to only ports to use .from_port
