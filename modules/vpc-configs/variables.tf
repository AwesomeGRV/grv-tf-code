variable "namespace" {
  type        = string
  description = "Namespace for resource naming and tagging."
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.namespace))
    error_message = "Namespace must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "aws_region" {
  type        = string
  description = "AWS region where resources are deployed."
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.aws_region))
    error_message = "The AWS region must be a valid AWS region name."
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to associate with VPC flow logs."
  
  validation {
    condition     = can(regex("^vpc-[a-f0-9]+$", var.vpc_id))
    error_message = "VPC ID must be a valid AWS VPC ID format."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."
  default     = {}
}
