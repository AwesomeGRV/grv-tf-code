output "public_network_acl_id" {
  description = "ID of the public Network ACL."
  value       = var.create_public_acl ? aws_network_acl.public[0].id : null
}

output "private_network_acl_id" {
  description = "ID of the private Network ACL."
  value       = var.create_private_acl ? aws_network_acl.private[0].id : null
}

output "public_network_acl_arn" {
  description = "ARN of the public Network ACL."
  value       = var.create_public_acl ? aws_network_acl.public[0].arn : null
}

output "private_network_acl_arn" {
  description = "ARN of the private Network ACL."
  value       = var.create_private_acl ? aws_network_acl.private[0].arn : null
}
