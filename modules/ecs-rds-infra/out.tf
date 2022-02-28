output "ecs_cluster_name" {
  description = "The name of ECS cluster"
  value       = local.ecs_cluster_name
}

output "db_instance_endpoint" {
  description = "The connection endpoint of RDS instance"
  value       = module.db_dev.db_instance_endpoint
}

output "db_password" {
  description = "The database password"
  value       = local.rds_db_password
}