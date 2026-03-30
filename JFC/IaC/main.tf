# Main Terraform Configuration for JFC E-Commerce Platform
# Author: Infrastructure Team
# Version: 1.0.0

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket         = "jfc-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "jfc-terraform-locks"
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Infrastructure Team"
    }
  }
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

# Local variables
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Networking Module
module "networking" {
  source = "./modules/networking"
  
  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  availability_zones  = local.azs
  enable_nat_gateway  = var.enable_nat_gateway
  enable_vpn_gateway  = var.enable_vpn_gateway
  
  tags = local.common_tags
}

# Security Module
module "security" {
  source = "./modules/security"
  
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.networking.vpc_id
  
  tags = local.common_tags
}

# DNS Module (Route 53)
module "dns" {
  source = "./modules/dns"
  
  project_name        = var.project_name
  environment         = var.environment
  domain_name         = var.domain_name
  create_hosted_zone  = var.create_hosted_zone
  hosted_zone_id      = var.hosted_zone_id
  
  # Will be populated after frontend and backend are created
  cloudfront_domain_name = module.frontend.cloudfront_domain_name
  cloudfront_zone_id     = "Z2FDTNDATAQYW2" # CloudFront zone ID (constant)
  alb_dns_name           = module.backend.alb_dns_name
  alb_zone_id            = module.backend.alb_zone_id
  
  enable_health_checks = var.enable_health_checks
  create_www_record    = var.create_www_record
  alarm_actions        = [module.monitoring.sns_topic_arn]
  
  tags = local.common_tags
  
  depends_on = [module.frontend, module.backend]
}

# Frontend Module (CloudFront + S3)
module "frontend" {
  source = "./modules/frontend"
  
  project_name    = var.project_name
  environment     = var.environment
  domain_name     = var.domain_name
  certificate_arn = var.acm_certificate_arn
  
  tags = local.common_tags
}

# WAF Module (Web Application Firewall)
module "waf" {
  source = "./modules/waf"
  
  project_name = var.project_name
  environment  = var.environment
  scope        = "REGIONAL" # For ALB
  resource_arn = module.backend.alb_arn
  
  rate_limit                  = var.waf_rate_limit
  blocked_countries           = var.waf_blocked_countries
  log_retention_days          = 30
  blocked_requests_threshold  = 100
  alarm_actions               = [module.monitoring.sns_topic_arn]
  
  tags = local.common_tags
  
  depends_on = [module.backend]
}

# Cache Module (ElastiCache Redis)
module "cache" {
  source = "./modules/cache"
  
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids
  security_group_ids = [module.security.redis_security_group_id]
  node_type          = var.redis_node_type
  num_cache_nodes    = var.redis_num_nodes
  
  tags = local.common_tags
}

# Database Module (Aurora Serverless v2)
module "database" {
  source = "./modules/database"
  
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.data_subnet_ids
  security_group_ids = [module.security.aurora_security_group_id]
  
  database_name      = var.database_name
  master_username    = var.database_master_username
  
  min_capacity       = var.aurora_min_capacity
  max_capacity       = var.aurora_max_capacity
  
  backup_retention_period = var.backup_retention_period
  
  tags = local.common_tags
}

# Backend Module (ECS Fargate + ALB)
module "backend" {
  source = "./modules/backend"
  
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  
  alb_security_group_id = module.security.alb_security_group_id
  ecs_security_group_id = module.security.ecs_security_group_id
  
  certificate_arn = var.acm_certificate_arn
  
  # Database connection
  database_endpoint = module.database.cluster_endpoint
  database_name     = var.database_name
  database_secret_arn = module.database.master_user_secret_arn
  
  # Cache connection
  redis_endpoint = module.cache.redis_endpoint
  
  # ECS configuration
  ecs_task_cpu    = var.ecs_task_cpu
  ecs_task_memory = var.ecs_task_memory
  ecs_min_tasks   = var.ecs_min_tasks
  ecs_max_tasks   = var.ecs_max_tasks
  
  tags = local.common_tags
}

# Monitoring Module (CloudWatch + X-Ray)
module "monitoring" {
  source = "./modules/monitoring"
  
  project_name = var.project_name
  environment  = var.environment
  
  # Resources to monitor
  alb_arn         = module.backend.alb_arn
  ecs_cluster_name = module.backend.ecs_cluster_name
  aurora_cluster_id = module.database.cluster_id
  redis_cluster_id  = module.cache.redis_cluster_id
  
  # Notification settings
  alarm_email = var.alarm_email
  
  tags = local.common_tags
}
