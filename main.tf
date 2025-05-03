provider "aws" {
  region = "us-east-1"
}

module "network" {
  source                         = "./modules/network"
  vpc_id                         = var.vpc_id
  private_subnet_ids             = var.private_subnet_ids
  security_group_id              = var.security_group_id
  transit_gateway_id             = var.transit_gateway_id
  transit_gateway_attachment_ids = var.transit_gateway_attachment_ids
  route_table_ids                = var.route_table_ids
}

module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name
}

module "ecs" {
  source            = "./modules/ecs"
  ecs_cluster_name  = var.ecs_cluster_name
  ecs_service_name  = var.ecs_service_name
  container_name    = var.container_name
  container_image   = var.container_image
  security_group_id = module.network.security_group_id
  subnet_ids        = module.network.private_subnet_ids
}

module "alb" {
  source            = "./modules/alb"
  alb_name          = "internal-alb" 
  security_group_id = module.network.security_group_id
  subnet_ids        = module.network.private_subnet_ids
  vpc_id            = var.vpc_id
}

module "cloudwatch" {
  source            = "./modules/cloudwatch"
  ecs_service_name  = var.ecs_service_name
  retention_in_days = 30
}