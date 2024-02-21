output "vpc" {
  value = aws_vpc.SG_vpc

}



output "from_port" {
  value = aws_security_group.SG_group[*]

}

output "lb_arn" {
  value = aws_lb.loadblance.arn

}

output "tg_arn" {
  value = aws_lb_target_group.tg.arn

}