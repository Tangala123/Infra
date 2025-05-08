output "ecs_cluster_id" {
  value = aws_ecs_cluster.cvist-ecs-cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.cvist-ecs-service.name
}
