// data "aws_availability_zones" "available_zone" {}

data "aws_ami" "latest_amazon_linux_2_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_name]
  }
}