variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID of the existing security group"
  type        = string
}

variable "transit_gateway_id" {
  description = "ID of the existing Transit Gateway"
  type        = string
}

variable "transit_gateway_attachment_ids" {
  description = "List of Transit Gateway attachment IDs"
  type        = list(string)
}

variable "route_table_ids" {
  description = "List of route table IDs"
  type        = list(string)
}

variable "ecr_repo_name" {
  description = "ECR Repository Name"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "ECR container image URI"
  type        = string
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}
