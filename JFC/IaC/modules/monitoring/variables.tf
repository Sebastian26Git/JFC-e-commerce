variable "project_name" { type = string }
variable "environment" { type = string }
variable "alb_arn" { type = string }
variable "ecs_cluster_name" { type = string }
variable "aurora_cluster_id" { type = string }
variable "redis_cluster_id" { type = string }
variable "alarm_email" { type = string }
variable "tags" { type = map(string); default = {} }
