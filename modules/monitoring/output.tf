output "sns_topic_arn" {
  description = "The SNS Topic ARN Value"
  value = aws_sns_topic.user_updates.arn
}

output "alarm_name" {
  description = "The alarm name"
  value = aws_cloudwatch_metric_alarm.cloudwatch_monitoring.alarm_name
}