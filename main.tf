

resource "aws_s3_bucket" "images-bucket" {
  bucket = "terraform-test-bucket-20251228"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}