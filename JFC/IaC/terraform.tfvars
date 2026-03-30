aws_region  = "us-east-1"
project_name = "jfc-ecommerce"
environment = "prod"

# Networking
vpc_cidr           = "10.0.0.0/16"
enable_nat_gateway = true
enable_vpn_gateway = false

# Frontend
domain_name         = "jfc-ecommerce.com"
acm_certificate_arn = ""  # Add your ACM certificate ARN

# Database
database_name           = "jfcecommerce"
database_master_username = "admin"
aurora_min_capacity     = 0.5
aurora_max_capacity     = 16
backup_retention_period = 7

# Cache
redis_node_type  = "cache.t4g.medium"
redis_num_nodes  = 2

# ECS
ecs_task_cpu    = 512
ecs_task_memory = 1024
ecs_min_tasks   = 2
ecs_max_tasks   = 10

# Monitoring
alarm_email = "ops@jfc-ecommerce.com"
