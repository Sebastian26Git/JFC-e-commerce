variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "node_type" { type = string; default = "cache.t4g.medium" }
variable "num_cache_nodes" { type = number; default = 2 }
variable "tags" { type = map(string); default = {} }
