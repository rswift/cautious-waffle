#
# Create a CloudWatch Log Groups
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
#
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ephemeral/logs"
  retention_in_days = 3

  tags = {
    "cost:allocation" = "work"
  }
}

#
# https://www.terraform.io/docs/language/values/outputs.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group#attributes-reference
#
output "log_group_arn" {
  value       = aws_cloudwatch_log_group.log_group.arn
  description = "ARN of the newly created CloudWatch Log Group"
}
