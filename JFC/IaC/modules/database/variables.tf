variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "database_name" { type = string }
variable "master_username" { type = string }
variable "min_capacity" { type = number; default = 0.5 }
variable "max_capacity" { type = number; default = 16 }
variable "backup_retention_period" { type = number; default = 7 }
variable "tags" { type = map(string); default = {} }
