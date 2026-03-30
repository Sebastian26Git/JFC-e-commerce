output "cluster_id" { value = aws_rds_cluster.main.id }
output "cluster_endpoint" { value = aws_rds_cluster.main.endpoint }
output "reader_endpoint" { value = aws_rds_cluster.main.reader_endpoint }
output "master_user_secret_arn" { value = aws_secretsmanager_secret.db_master.arn }
