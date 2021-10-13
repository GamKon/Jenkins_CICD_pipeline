output "security_group" {
  value = aws_default_security_group.sg-http80-https443-ssh22
}
output "vpc" {
  value = aws_vpc.vpc-for-my-progect
}
output "subnet_1" {
  value = aws_subnet.subnet-for-my-project
}
