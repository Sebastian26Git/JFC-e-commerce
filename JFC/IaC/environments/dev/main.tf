# Development Environment Configuration

terraform {
  required_version = ">= 1.5.0"
  
  backend "s3" {
    bucket         = "jfc-terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "jfc-terraform-locks-dev"
  }
}

module "infrastructure" {
  source = "../../"
  
  aws_region   = "us-east-1"
  project_name = "jfc-ecommerce"
  environment  = "dev"
  
  # Development-specific overrides
  enable_nat_gateway      = false  # Cost optimization
  backup_retention_period = 3
  ecs_min_tasks           = 1
  ecs_max_tasks           = 3
  aurora_min_capacity     = 0.5
  aurora_max_capacity     = 2
  redis_node_type         = "cache.t4g.micro"
}
