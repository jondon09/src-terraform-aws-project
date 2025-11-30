terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "iamadmin-general"
}

resource "aws_s3_bucket" "images-bucket" {
  bucket = "terraform-test-bucket-20251228"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}