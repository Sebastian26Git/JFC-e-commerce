output "sns_topic_arn" { value = aws_sns_topic.alarms.arn }
output "dashboard_url" { 
  value = "https://console.aws.amazon.com/cloudwatch/home?region=${data.aws_region.current.name}#dashboards:name=${aws_cloudwatch_dashboard.main.dashboard_name}"
}
