variable "aws_region" {
  description = "The aws region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "profile for Deploying resource on AWS"
  type        = string
  default     = "iamadmin-general"
}

variable "aws_tagging" {
  description = "Tags to set on AWS objects"
  type        = map(string)
  default = {
    "Team"        = "GCA-platform"
    "Environment" = "dev"
  }
}

variable "desired_azs" {
  type    = list(string)
  default = ["us-east-1f", "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}