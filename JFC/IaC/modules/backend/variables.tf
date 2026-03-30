variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "alb_security_group_id" { type = string }
variable "ecs_security_group_id" { type = string }
variable "certificate_arn" { type = string; default = "" }
variable "database_endpoint" { type = string }
variable "database_name" { type = string }
variable "database_secret_arn" { type = string }
variable "redis_endpoint" { type = string }
variable "ecs_task_cpu" { type = number; default = 512 }
variable "ecs_task_memory" { type = number; default = 1024 }
variable "ecs_min_tasks" { type = number; default = 2 }
variable "ecs_max_tasks" { type = number; default = 10 }
variable "tags" { type = map(string); default = {} }
