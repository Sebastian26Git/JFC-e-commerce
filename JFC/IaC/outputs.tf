# Outputs for JFC E-Commerce Platform

# Networking Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.networking.private_subnet_ids
}

# Frontend Outputs
output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.frontend.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.frontend.cloudfront_domain_name
}

output "s3_bucket_name" {
  description = "S3 bucket name for frontend"
  value       = module.frontend.s3_bucket_name
}

# DNS Outputs
output "hosted_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = module.dns.hosted_zone_id
}

output "hosted_zone_name_servers" {
  description = "Route 53 hosted zone name servers"
  value       = module.dns.hosted_zone_name_servers
}

output "domain_name" {
  description = "Domain name"
  value       = var.domain_name
}

output "api_domain_name" {
  description = "API domain name"
  value       = module.dns.alb_record_name
}

# WAF Outputs
output "waf_web_acl_id" {
  description = "WAF Web ACL ID"
  value       = module.waf.web_acl_id
}

output "waf_web_acl_arn" {
  description = "WAF Web ACL ARN"
  value       = module.waf.web_acl_arn
}

# Backend Outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.backend.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = module.backend.alb_zone_id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.backend.ecs_cluster_name
}

output "ecs_service_names" {
  description = "Names of ECS services"
  value       = module.backend.ecs_service_names
}

# Database Outputs
output "aurora_cluster_endpoint" {
  description = "Aurora cluster endpoint"
  value       = module.database.cluster_endpoint
  sensitive   = true
}

output "aurora_reader_endpoint" {
  description = "Aurora reader endpoint"
  value       = module.database.reader_endpoint
  sensitive   = true
}

output "database_name" {
  description = "Name of the database"
  value       = var.database_name
}

# Cache Outputs
output "redis_endpoint" {
  description = "Redis cluster endpoint"
  value       = module.cache.redis_endpoint
  sensitive   = true
}

output "redis_port" {
  description = "Redis cluster port"
  value       = module.cache.redis_port
}

# Monitoring Outputs
output "cloudwatch_dashboard_url" {
  description = "URL to CloudWatch dashboard"
  value       = module.monitoring.dashboard_url
}

output "sns_topic_arn" {
  description = "ARN of SNS topic for alarms"
  value       = module.monitoring.sns_topic_arn
}

# Deployment Information
output "deployment_info" {
  description = "Deployment information"
  value = {
    region      = var.aws_region
    environment = var.environment
    project     = var.project_name
    timestamp   = timestamp()
  }
}

# Connection Strings (for application configuration)
output "application_config" {
  description = "Application configuration (sensitive)"
  value = {
    database_endpoint = module.database.cluster_endpoint
    redis_endpoint    = module.cache.redis_endpoint
    alb_endpoint      = module.backend.alb_dns_name
  }
  sensitive = true
}
