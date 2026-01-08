variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region where all resources will be deployed."
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.aws_region))
    error_message = "The AWS region must be a valid AWS region name."
  }
}
