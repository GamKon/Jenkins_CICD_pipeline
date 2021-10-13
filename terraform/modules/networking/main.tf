resource "aws_default_security_group" "sg-http80-https443-ssh22" {
  vpc_id = aws_vpc.vpc-for-my-progect.id

  dynamic "ingress" {
    for_each = var.ports_to_open
    content {
      description      = "inbound from the internet"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  }
  ingress {
    description      = "inbound SSH port 22 from white list variable"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ip_for_ssh_inbound_connection]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress = [{
    description      = "Outbound everything"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]
  tags = merge(var.tags_common, { Name : "${var.project_name}-${var.project_environment}-allow-http-https-ssh-from-0" })
}

resource "aws_vpc" "vpc-for-my-progect" {
  cidr_block = var.vpc_cidr_block
  tags       = merge(var.tags_common, { Name : "${var.project_name}-${var.project_environment}-vpc" })
}

resource "aws_subnet" "subnet-for-my-project" {
  vpc_id            = aws_vpc.vpc-for-my-progect.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.az_project_in
  tags              = merge(var.tags_common, { Name : "${var.project_name}-${var.project_environment}-subnet-1" })
}

resource "aws_internet_gateway" "igw-for-my-project" {
  vpc_id = aws_vpc.vpc-for-my-progect.id
  tags   = merge(var.tags_common, { Name : "${var.project_name}-${var.project_environment}-internet-gw" })
}

resource "aws_default_route_table" "default-route-table" {
  default_route_table_id = aws_vpc.vpc-for-my-progect.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-for-my-project.id
  }
  tags = merge(var.tags_common, { Name : "${var.project_name}-${var.project_environment}-route-table" })
}