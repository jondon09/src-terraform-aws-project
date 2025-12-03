resource "aws_instance" "instance" {
  ami           = ""
  instance_type = var.instance_type
  root_block_device {
    encrypted = true
  }
  tags = var.tagging
}