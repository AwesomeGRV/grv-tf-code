output "log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for VPC flow logs."
  value       = aws_cloudwatch_log_group.flow_logs.arn
}

output "log_group_name" {
  description = "The name of the CloudWatch Log Group for VPC flow logs."
  value       = aws_cloudwatch_log_group.flow_logs.name
}

output "flow_log_arn" {
  description = "The ARN of the VPC Flow Log."
  value       = aws_flow_log.vpcflowlog.arn
}

output "flow_log_id" {
  description = "The ID of the VPC Flow Log."
  value       = aws_flow_log.vpcflowlog.id
}

output "iam_role_arn" {
  description = "The ARN of the IAM role for VPC flow logs."
  value       = aws_iam_role.flow_logs_role.arn
}

output "iam_policy_arn" {
  description = "The ARN of the IAM policy for VPC flow logs."
  value       = aws_iam_policy.vpc_flowlog_policy.arn
}
