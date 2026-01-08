variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."
  default     = {}
}

variable "namespace" {
  type        = string
  description = "Namespace for resource naming and tagging."
  default     = "terraform"
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.namespace))
    error_message = "Namespace must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_id_dev" {
  type        = string
  description = "VPC ID for the development environment."
  
  validation {
    condition     = can(regex("^vpc-[a-f0-9]+$", var.vpc_id_dev))
    error_message = "VPC ID must be a valid AWS VPC ID format."
  }
}

variable "vpc_id_manage" {
  type        = string
  description = "VPC ID for the management environment."
  
  validation {
    condition     = can(regex("^vpc-[a-f0-9]+$", var.vpc_id_manage))
    error_message = "VPC ID must be a valid AWS VPC ID format."
  }
}

variable "vpc_id_prod" {
  type        = string
  description = "VPC ID for the production environment."
  
  validation {
    condition     = can(regex("^vpc-[a-f0-9]+$", var.vpc_id_prod))
    error_message = "VPC ID must be a valid AWS VPC ID format."
  }
}

variable "transit_gateway_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the Transit Gateway. Set to null for default behavior."
  default     = null
}

variable "vpn_ecmp_support" {
  type        = string
  description = "Enable/disable VPN ECMP support for the Transit Gateway."
  default     = "enable"
  
  validation {
    condition = contains(["enable", "disable"], var.vpn_ecmp_support)
    error_message = "VPN ECMP support must be either 'enable' or 'disable'."
  }
}

variable "dns_support" {
  type        = string
  description = "Enable/disable DNS support for the Transit Gateway."
  default     = "enable"
  
  validation {
    condition = contains(["enable", "disable"], var.dns_support)
    error_message = "DNS support must be either 'enable' or 'disable'."
  }
}

variable "default_route_table_propagation" {
  type        = string
  description = "Enable/disable default route table propagation for the Transit Gateway."
  default     = "enable"
  
  validation {
    condition = contains(["enable", "disable"], var.default_route_table_propagation)
    error_message = "Default route table propagation must be either 'enable' or 'disable'."
  }
}

variable "default_route_table_association" {
  type        = string
  description = "Enable/disable default route table association for the Transit Gateway."
  default     = "enable"
  
  validation {
    condition = contains(["enable", "disable"], var.default_route_table_association)
    error_message = "Default route table association must be either 'enable' or 'disable'."
  }
}

variable "auto_accept_shared_attachments" {
  type        = string
  description = "Enable/disable auto-accept shared attachments for the Transit Gateway."
  default     = "disable"
  
  validation {
    condition = contains(["enable", "disable"], var.auto_accept_shared_attachments)
    error_message = "Auto accept shared attachments must be either 'enable' or 'disable'."
  }
}

variable "subnet_dev" {
  type        = list(string)
  description = "List of subnet IDs for the development environment attachment."
  
  validation {
    condition     = length(var.subnet_dev) > 0
    error_message = "At least one development subnet ID must be provided."
  }
}

variable "subnet_manage" {
  type        = list(string)
  description = "List of subnet IDs for the management environment attachment."
  
  validation {
    condition     = length(var.subnet_manage) > 0
    error_message = "At least one management subnet ID must be provided."
  }
}

variable "subnet_prod" {
  type        = list(string)
  description = "List of subnet IDs for the production environment attachment."
  
  validation {
    condition     = length(var.subnet_prod) > 0
    error_message = "At least one production subnet ID must be provided."
  }
}

############# aws route variables

variable "rt_table_dev_a" {
  type        = string
  description = "Route table ID for development environment route A."
  
  validation {
    condition     = can(regex("^rtb-[a-f0-9]+$", var.rt_table_dev_a))
    error_message = "Route table ID must be a valid AWS route table ID format."
  }
}

variable "dest_dev" {
  type        = list(string)
  description = "Destination CIDR blocks for development environment routing."
  
  validation {
    condition     = length(var.dest_dev) > 0
    error_message = "At least one destination CIDR must be provided for development."
  }
}

variable "rt_table_manage_a" {
  type        = string
  description = "Route table ID for management environment route A."
  
  validation {
    condition     = can(regex("^rtb-[a-f0-9]+$", var.rt_table_manage_a))
    error_message = "Route table ID must be a valid AWS route table ID format."
  }
}

#variable "rt_table_manage_b" {
#  type = string
#}

variable "rt_table_manage_c" {
  type        = string
  description = "Route table ID for management environment route C."
  
  validation {
    condition     = can(regex("^rtb-[a-f0-9]+$", var.rt_table_manage_c))
    error_message = "Route table ID must be a valid AWS route table ID format."
  }
}

variable "rt_table_manage_d" {
  type        = string
  description = "Route table ID for management environment route D."
  
  validation {
    condition     = can(regex("^rtb-[a-f0-9]+$", var.rt_table_manage_d))
    error_message = "Route table ID must be a valid AWS route table ID format."
  }
}

variable "dest_manage" {
  type        = list(string)
  description = "Destination CIDR blocks for management environment routing."
  
  validation {
    condition     = length(var.dest_manage) > 0
    error_message = "At least one destination CIDR must be provided for management."
  }
}

variable "rt_table_prod_a" {
  type        = string
  description = "Route table ID for production environment route A."
  
  validation {
    condition     = can(regex("^rtb-[a-f0-9]+$", var.rt_table_prod_a))
    error_message = "Route table ID must be a valid AWS route table ID format."
  }
}

variable "dest_prod" {
  type        = list(string)
  description = "Destination CIDR blocks for production environment routing."
  
  validation {
    condition     = length(var.dest_prod) > 0
    error_message = "At least one destination CIDR must be provided for production."
  }
}
