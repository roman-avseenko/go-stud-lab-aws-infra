output "ecs_cluster_name" {
  description = "The name of ECS cluster"
  value       = module.aws_infra.ecs_cluster_name
}

output "db_instance_endpoint" {
  description = "The connection endpoint of RDS instance"
  value       = module.aws_infra.db_instance_endpoint
}

output "db_password" {
  description = "The database password"
  value       = module.aws_infra.db_password
}