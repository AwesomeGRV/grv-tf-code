variable "namespace" {
  type        = string
  description = "Namespace for resource naming and tagging."
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.namespace))
    error_message = "Namespace must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where Network ACLs will be created."
  
  validation {
    condition     = can(regex("^vpc-[a-f0-9]+$", var.vpc_id))
    error_message = "VPC ID must be a valid AWS VPC ID format."
  }
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC for private ACL rules."
  
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR notation."
  }
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs to associate with public Network ACL."
  default     = []
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs to associate with private Network ACL."
  default     = []
}

variable "create_public_acl" {
  type        = bool
  description = "Whether to create public Network ACL."
  default     = true
}

variable "create_private_acl" {
  type        = bool
  description = "Whether to create private Network ACL."
  default     = true
}

variable "allow_ssh" {
  type        = bool
  description = "Whether to allow SSH access to public subnets."
  default     = false
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR block allowed for SSH access."
  default     = "0.0.0.0/0"
  
  validation {
    condition     = can(cidrhost(var.ssh_allowed_cidr, 0))
    error_message = "SSH allowed CIDR must be a valid IPv4 CIDR notation."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."
  default     = {}
}
