output "alb_security_group_id" { value = aws_security_group.alb.id }
output "ecs_security_group_id" { value = aws_security_group.ecs.id }
output "aurora_security_group_id" { value = aws_security_group.aurora.id }
output "redis_security_group_id" { value = aws_security_group.redis.id }
output "kms_key_id" { value = aws_kms_key.main.id }
output "kms_key_arn" { value = aws_kms_key.main.arn }
