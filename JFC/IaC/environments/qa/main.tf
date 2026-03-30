# Staging Environment Configuration

terraform {
  required_version = ">= 1.5.0"
  
  backend "s3" {
    bucket         = "jfc-terraform-state-staging"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "jfc-terraform-locks-staging"
  }
}

module "infrastructure" {
  source = "../../"
  
  aws_region   = "us-east-1"
  project_name = "jfc-ecommerce"
  environment  = "staging"
  
  # Staging-specific overrides (similar a prod pero más económico)
  enable_nat_gateway      = true
  backup_retention_period = 7
  ecs_min_tasks           = 2
  ecs_max_tasks           = 8
  aurora_min_capacity     = 0.5
  aurora_max_capacity     = 8
  redis_node_type         = "cache.t4g.small"
  redis_num_nodes         = 2
}
