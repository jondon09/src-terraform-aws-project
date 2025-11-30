

resource "aws_s3_bucket" "images-bucket" {
  bucket = var.aws_s3_bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}