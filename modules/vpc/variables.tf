variable "cidr" {
  type        = string
  description = "CIDR block for the VPC."
  
  validation {
    condition     = can(cidrhost(var.cidr, 0))
    error_message = "The CIDR block must be a valid IPv4 CIDR notation."
  }
}

variable "subnet_cidr" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets."
  
  validation {
    condition     = length(var.subnet_cidr) > 0
    error_message = "At least one subnet CIDR must be provided."
  }
}

variable "private_subnet_cidr" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets."
  
  validation {
    condition     = length(var.private_subnet_cidr) > 0
    error_message = "At least one private subnet CIDR must be provided."
  }
}

variable "avail_zone" {
  type        = list(string)
  description = "List of availability zones for public subnets."
  
  validation {
    condition     = length(var.avail_zone) > 0
    error_message = "At least one availability zone must be provided."
  }
}

variable "private_avail_zone" {
  type        = list(string)
  description = "List of availability zones for private subnets."
  
  validation {
    condition     = length(var.private_avail_zone) > 0
    error_message = "At least one private availability zone must be provided."
  }
}

variable "global_ip" {
  type        = string
  description = "CIDR block for internet access (typically 0.0.0.0/0)."
  
  validation {
    condition     = var.global_ip == "0.0.0.0/0"
    error_message = "Global IP should be set to 0.0.0.0/0 for internet access."
  }
}

variable "namespace" {
  type        = string
  description = "Namespace for resource naming and tagging."
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.namespace))
    error_message = "Namespace must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."
  default     = {}
}
