output "transit_gateway_id" {
  description = "The ID of the Transit Gateway."
  value       = aws_ec2_transit_gateway.this.id
}

output "transit_gateway_arn" {
  description = "The ARN of the Transit Gateway."
  value       = aws_ec2_transit_gateway.this.arn
}

output "transit_gateway_attachment_dev_id" {
  description = "The ID of the Transit Gateway attachment for development VPC."
  value       = aws_ec2_transit_gateway_vpc_attachment.attachment-1.id
}

output "transit_gateway_attachment_manage_id" {
  description = "The ID of the Transit Gateway attachment for management VPC."
  value       = aws_ec2_transit_gateway_vpc_attachment.attachment-2.id
}

output "transit_gateway_attachment_prod_id" {
  description = "The ID of the Transit Gateway attachment for production VPC."
  value       = aws_ec2_transit_gateway_vpc_attachment.attachment-3.id
}

output "transit_gateway_attachment_dev_arn" {
  description = "The ARN of the Transit Gateway attachment for development VPC."
  value       = aws_ec2_transit_gateway_vpc_attachment.attachment-1.arn
}

output "transit_gateway_attachment_manage_arn" {
  description = "The ARN of the Transit Gateway attachment for management VPC."
  value       = aws_ec2_transit_gateway_vpc_attachment.attachment-2.arn
}

output "transit_gateway_attachment_prod_arn" {
  description = "The ARN of the Transit Gateway attachment for production VPC."
  value       = aws_ec2_transit_gateway_vpc_attachment.attachment-3.arn
}
