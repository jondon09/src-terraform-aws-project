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