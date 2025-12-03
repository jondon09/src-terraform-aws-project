
module "ec2_instance" {
  source        = "./modules/ec2"
  instance_type = "t3.micro"
  image_os      = "ubuntu"
  tagging = {
    "Name"         = "webServer-Instance"
    "BusinessUnit" = "GCA-Platform"
  }
}



resource "aws_s3_bucket" "resource_to_import" {
  bucket = "s3-bucket-import-2025-12-01"
  tags   = var.aws_tagging

}
resource "aws_s3_bucket" "images-bucket" {
  bucket = var.aws_s3_bucket_name

  tags = var.aws_tagging
}