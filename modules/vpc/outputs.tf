output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.vpc.cidr_block
}

output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.vpc.arn
}

output "subnet_pub" {
  description = "List of IDs of public subnets."
  value       = aws_subnet.public-subnet[*].id
}

output "subnet_pri" {
  description = "List of IDs of private subnets."
  value       = aws_subnet.private-subnet[*].id
}

output "route_table_pub" {
  description = "List of IDs of public route tables."
  value       = aws_route_table.public-rt[*].id
}

output "route_table_pri_dev" {
  description = "List of IDs of private route tables for dev environment."
  value       = aws_route_table.private-rt-optional[*].id
}

output "route_table_pri_manage" {
  description = "List of IDs of private route tables for management environment."
  value       = aws_route_table.private-rt[*].id
}

output "route_table_pri_prod" {
  description = "List of IDs of private route tables for production environment."
  value       = aws_route_table.private-rt-optional[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = var.namespace == "management" ? aws_internet_gateway.igw[0].id : null
}

output "nat_gateway_ids" {
  description = "List of IDs of NAT Gateways."
  value       = aws_nat_gateway.gw[*].id
}

output "nat_eip_ids" {
  description = "List of allocation IDs of NAT EIPs."
  value       = aws_eip.nat[*].id
}
