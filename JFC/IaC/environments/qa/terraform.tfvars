# Staging Environment Variables

aws_region   = "us-east-1"
project_name = "jfc-ecommerce"
environment  = "staging"

# Networking
vpc_cidr           = "10.1.0.0/16"  # CIDR diferente a prod
enable_nat_gateway = true
enable_vpn_gateway = false

# Frontend
domain_name         = "staging.jfc-ecommerce.com"
acm_certificate_arn = ""  # Agregar certificado SSL

# Database - Configuración intermedia
database_name            = "jfcecommerce_staging"
database_master_username = "admin"
aurora_min_capacity      = 0.5
aurora_max_capacity      = 8
backup_retention_period  = 7

# Cache - Configuración intermedia
redis_node_type = "cache.t4g.small"
redis_num_nodes = 2

# ECS - Configuración intermedia
ecs_task_cpu    = 512
ecs_task_memory = 1024
ecs_min_tasks   = 2
ecs_max_tasks   = 8

# Monitoring
alarm_email = "staging-alerts@jfc-ecommerce.com"

# Tags adicionales
additional_tags = {
  CostCenter = "QA"
  Owner      = "QATeam"
  Purpose    = "Pre-Production Testing"
}
