# Production Environment Outputs

output "environment" {
  description = "Environment name"
  value       = "prod"
}

output "alb_endpoint" {
  description = "ALB endpoint for API"
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

output "production_urls" {
  description = "Production URLs"
  value = {
    website     = "https://jfc-ecommerce.com"
    api         = "https://api.jfc-ecommerce.com"
    dashboard   = module.infrastructure.cloudwatch_dashboard_url
  }
}

output "deployment_info" {
  description = "Deployment information"
  value = {
    region      = "us-east-1"
    environment = "prod"
    deployed_at = timestamp()
  }
}
