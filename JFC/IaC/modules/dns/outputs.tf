# DNS Module Outputs

output "hosted_zone_id" {
  description = "Hosted zone ID"
  value       = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
}

output "hosted_zone_name_servers" {
  description = "Name servers for the hosted zone"
  value       = var.create_hosted_zone ? aws_route53_zone.main[0].name_servers : []
}

output "cloudfront_record_name" {
  description = "CloudFront record name"
  value       = var.cloudfront_domain_name != "" ? aws_route53_record.cloudfront[0].name : ""
}

output "alb_record_name" {
  description = "ALB record name"
  value       = var.alb_dns_name != "" ? aws_route53_record.alb[0].name : ""
}

output "health_check_id" {
  description = "Health check ID"
  value       = var.alb_dns_name != "" && var.enable_health_checks ? aws_route53_health_check.alb[0].id : ""
}
