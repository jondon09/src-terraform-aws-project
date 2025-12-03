resource "aws_instance" "instance" {
  ami                    = local.image
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.vpc_security_group.id]

  root_block_device {
    encrypted = true
  }
  tags = var.tagging
}

# Store the AMI IDs that we retrieve

locals {
  ubuntu = var.image_os == "ubuntu" ? data.aws_ami.ubuntu_server_latest.id : null
  amazon = var.image_os == "amazon linux" ? data.aws_ami.amazon_linux_latest.id : null
  image  = coalesce(local.ubuntu, local.amazon)
}

# Retrieve latest Amazon Linux AMI
# Data blocks used to read data from external source
data "aws_ami" "amazon_linux_latest" {
  most_recent = true
  owners       = ["amazon"]
  filter {
    name   = "name"
    values = ["*al2023-ami-2023*-x86_64*"]
  }
  filter {
    name   = "platform-details"
    values = ["Linux/UNIX"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Retrieve latest Ubuntu Server AMI
data "aws_ami" "ubuntu_server_latest" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "platform-details"
    values = ["Linux/UNIX"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

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
  security_group_id = aws_security_group.vpc_security_group.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}