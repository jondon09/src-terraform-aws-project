// custom VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = var.aws_tagging
}

// get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  filtered_azs = [for az in data.aws_availability_zones.available.names : az if contains(var.desired_azs, az)]
}

// subnet within the VPC
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = local.filtered_azs[0]
  tags              = var.aws_tagging
}

resource "aws_security_group" "vpc_security_group" {
  name        = "aws VPC sec Group"
  description = "aws vpc sec group for ec2"
  vpc_id      = aws_vpc.custom_vpc.id
  tags        = var.aws_tagging
}

// Ingress rules
resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.vpc_security_group.id

  cidr_ipv4   = aws_vpc.custom_vpc.cidr_block
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "example" {
  security_group_id = aws_security_group.vpc_security_group

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "ec2_host" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.vpc_security_group.id]
  tags                   = var.aws_tagging
}