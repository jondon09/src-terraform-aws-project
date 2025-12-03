variable "instance_type" {
  description = "Select the instance type. Options 't2.micro' or 't3.micro'"
  type        = string
  validation {
    condition     = (var.instance_type == "t2.micro" || var.instance_type == "t3.micro")
    error_message = "The instance type must be 't2.micro' or 't3.micro'"
  }
}

variable "tagging" {
  type        = map(string)
  description = "Add 'BusinessUnit and other tags' "

  validation {
    condition     = contains(keys(var.tagging), "BusinessUnit")
    error_message = "At least one tag Must be called BusinessUnit"
  }
}

variable "image_os" {
  type        = string
  description = "Select the image OS. Options of 'ubuntu' or 'amazon linux'"

  validation {
    condition     = (var.image_os == "ubuntu" || var.image_os == "amazon_linux")
    error_message = "The image_os must be 'ubuntu' or 'amazon_linux' "
  }
}

variable "aws_tagging" {
  description = "Tags to set on AWS objects"
  type        = map(string)
  default = {
    "Name"        = "GCA-platform"
    "BusinessUnit" = "GCA Platform"
  }
}

variable "desired_azs" {
  type    = list(string)
  default = ["us-east-1f", "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}