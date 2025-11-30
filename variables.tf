variable "aws_region" {
  description = "The aws region to deploy in"
  type = "string"
  default = "us-east-1"
}

variable "aws_profile" {
  description = "profile for Deploying resource on AWS"
  type = "string"
  default = "iamadmin-general"
}


variable "aws_s3_bucket_name"{
  description = "The Unique name of the AWS Bucket"
  type = "string"
  default = "terraform-test-bucket-20251228"
}

variable "aws_tags"  {
  description = "Tags to set on AWS objects"
  type        =  map(string)
  default = {
    "Team" = "GCA-platform"
    "Environment" = "dev"
  }
}