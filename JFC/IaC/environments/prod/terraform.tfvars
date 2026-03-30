# Production Environment Variables

aws_region   = "us-east-1"
project_name = "jfc-ecommerce"
environment  = "prod"

# Networking - Configuración completa
vpc_cidr           = "10.2.0.0/16"  # CIDR diferente
enable_nat_gateway = true
enable_vpn_gateway = false

# Frontend
domain_name         = "jfc-ecommerce.com"
acm_certificate_arn = "arn:aws:acm:us-east-1:ACCOUNT_ID:certificate/CERT_ID"  # Agregar certificado real

# Database - Configuración de producción
database_name            = "jfcecommerce"
database_master_username = "admin"
aurora_min_capacity      = 1
aurora_max_capacity      = 32
backup_retention_period  = 30  # 30 días en producción

# Cache - Configuración robusta
redis_node_type = "cache.t4g.medium"
redis_num_nodes = 3  # 3 nodos para alta disponibilidad

# ECS - Configuración de producción
ecs_task_cpu    = 512
ecs_task_memory = 1024
ecs_min_tasks   = 3   # Mínimo 3 tasks
ecs_max_tasks   = 20  # Máximo 20 tasks

# Monitoring
alarm_email = "ops@jfc-ecommerce.com"

# Tags adicionales
additional_tags = {
  CostCenter  = "Production"
  Owner       = "OpsTeam"
  Compliance  = "PCI-DSS"
  Criticality = "High"
  Backup      = "Required"
}
