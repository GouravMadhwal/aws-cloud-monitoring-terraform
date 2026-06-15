resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}

resource "aws_sns_topic_subscription" "user_updates_subscription" {
  protocol = "email"
  endpoint = var.email_id
  topic_arn = aws_sns_topic.user_updates.arn
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_monitoring" {
  alarm_name = "EC2_Operating_High"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold = var.threshold_value
  period = var.period_value
  evaluation_periods = var.evaluation_periods_value
  statistic = "Average"
  dimensions = {
    InstanceId = var.instance_id
  }
  alarm_actions = [aws_sns_topic.user_updates.arn]
}