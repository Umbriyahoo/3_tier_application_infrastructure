output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "subnet3_id" {
  value = aws_subnet.subnet3.id
}

output "subnet4_id" {
  value = aws_subnet.subnet4.id
}

output "subnet5_id" {
  value = aws_subnet.subnet5.id
}

output "subnet6_id" {
  value = aws_subnet.subnet6.id
}

output "bastion_host_ip" {
  value = aws_instance.bastion.public_ip
}

output "alb_dns_name" {
  description = "alb dns"
  value       = aws_lb.alb1.dns_name
}
