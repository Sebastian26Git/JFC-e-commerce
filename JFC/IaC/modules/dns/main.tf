# DNS Module - Route 53

# Hosted Zone
resource "aws_route53_zone" "main" {
  count = var.create_hosted_zone ? 1 : 0
  
  name = var.domain_name
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-hosted-zone"
    }
  )
}

# A Record for CloudFront (Frontend)
resource "aws_route53_record" "cloudfront" {
  count = var.cloudfront_domain_name != "" ? 1 : 0
  
  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = var.domain_name
  type    = "A"
  
  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

# A Record for ALB (API)
resource "aws_route53_record" "alb" {
  count = var.alb_dns_name != "" ? 1 : 0
  
  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = "api.${var.domain_name}"
  type    = "A"
  
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# Health Check for ALB
resource "aws_route53_health_check" "alb" {
  count = var.alb_dns_name != "" && var.enable_health_checks ? 1 : 0
  
  fqdn              = "api.${var.domain_name}"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/health"
  failure_threshold = 3
  request_interval  = 30
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-alb-health-check"
    }
  )
}

# CloudWatch Alarm for Health Check
resource "aws_cloudwatch_metric_alarm" "health_check" {
  count = var.alb_dns_name != "" && var.enable_health_checks ? 1 : 0
  
  alarm_name          = "${var.project_name}-${var.environment}-route53-health-check"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "Route 53 health check failed"
  
  dimensions = {
    HealthCheckId = aws_route53_health_check.alb[0].id
  }
  
  alarm_actions = var.alarm_actions
  
  tags = var.tags
}

# CNAME for www subdomain
resource "aws_route53_record" "www" {
  count = var.create_www_record ? 1 : 0
  
  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.domain_name]
}
