# Development Environment Variables

aws_region   = "us-east-1"
project_name = "jfc-ecommerce"
environment  = "dev"

# Networking - Optimizado para costos
vpc_cidr           = "10.0.0.0/16"
enable_nat_gateway = false  # Usar solo 1 NAT o ninguno para dev
enable_vpn_gateway = false

# Frontend
domain_name         = "dev.jfc-ecommerce.com"
acm_certificate_arn = ""  # Opcional en dev

# Database - Configuración mínima
database_name            = "jfcecommerce_dev"
database_master_username = "admin"
aurora_min_capacity      = 0.5
aurora_max_capacity      = 2
backup_retention_period  = 3  # Solo 3 días en dev

# Cache - Instancia pequeña
redis_node_type = "cache.t4g.micro"
redis_num_nodes = 1  # Solo 1 nodo en dev

# ECS - Configuración mínima
ecs_task_cpu    = 256   # Menos CPU
ecs_task_memory = 512   # Menos memoria
ecs_min_tasks   = 1     # Mínimo 1 task
ecs_max_tasks   = 3     # Máximo 3 tasks

# Monitoring
alarm_email = "dev-team@jfc-ecommerce.com"

# Tags adicionales
additional_tags = {
  CostCenter = "Development"
  Owner      = "DevTeam"
  AutoShutdown = "true"  # Para apagar fuera de horario
}
