data "aws_availability_zones" "available_zone" {}

data "aws_ami" "latest_amazon_linux_2_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}