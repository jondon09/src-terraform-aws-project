resource "aws_instance" "instance" {
  ami           = ""
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
  image = coalesce(local.ubuntu, local.amazon)
}

