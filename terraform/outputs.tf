output "VPC" {
  value = module.networking.vpc.id
}
output "Subnet-1" {
  value = module.networking.subnet_1.id
}
output "Security-group" {
  value = module.networking.security_group.id
}
output "Server-1" {
  value = module.ec2_webserver.server-1.id
}
output "Server-1-public-IP" {
  value = module.ec2_webserver.server-1.public_ip
}
