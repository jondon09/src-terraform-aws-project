resource "aws_instance" "instance" {
  ami           = local.image
  instance_type = var.instance_type
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
  owner       = ["amazon"]
  filter {
    name   = "name"
    values = ["*al2023-ami-2023*x86_64*"]
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
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server"]
  }
  filter {
    name   = "platform-details"
    values = ["Linux/UNIX"]
  }
  filter {
    name   = "root-device-type"
    values = [ebs]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}