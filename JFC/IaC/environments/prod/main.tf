# Production Environment Configuration

terraform {
  required_version = ">= 1.5.0"
  
  backend "s3" {
    bucket         = "jfc-terraform-state-prod"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "jfc-terraform-locks-prod"
  }
}

module "infrastructure" {
  source = "../../"
  
  aws_region   = "us-east-1"
  project_name = "jfc-ecommerce"
  environment  = "prod"
  
  # Production-specific overrides
  enable_nat_gateway      = true
  backup_retention_period = 30
  ecs_min_tasks           = 3
  ecs_max_tasks           = 20
  aurora_min_capacity     = 1
  aurora_max_capacity     = 32
}
