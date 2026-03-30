# Development Environment Outputs

output "environment" {
  description = "Environment name"
  value       = "dev"
}

output "alb_endpoint" {
  description = "ALB endpoint for API testing"
  value       = module.infrastructure.alb_dns_name
}

output "cloudfront_url" {
  description = "CloudFront URL for frontend"
  value       = "https://${module.infrastructure.cloudfront_domain_name}"
}

output "database_endpoint" {
  description = "Database endpoint (sensitive)"
  value       = module.infrastructure.aurora_cluster_endpoint
  sensitive   = true
}

output "redis_endpoint" {
  description = "Redis endpoint (sensitive)"
  value       = module.infrastructure.redis_endpoint
  sensitive   = true
}

output "s3_bucket" {
  description = "S3 bucket for frontend deployment"
  value       = module.infrastructure.s3_bucket_name
}

output "ecs_cluster" {
  description = "ECS cluster name"
  value       = module.infrastructure.ecs_cluster_name
}

output "quick_access" {
  description = "Quick access URLs"
  value = {
    frontend    = "https://${module.infrastructure.cloudfront_domain_name}"
    api         = "https://${module.infrastructure.alb_dns_name}/api"
    dashboard   = module.infrastructure.cloudwatch_dashboard_url
  }
}
