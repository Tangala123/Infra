resource "aws_iam_role" "ecs_task_role" {
  name               = "ecs_task_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })
}

resource "aws_ecs_cluster" "cvist-ecs-cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "cvist-ecs-task" {
  family                    = var.ecs_service_name
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                       = "256"
  memory                    = "512"
  
  container_definitions = jsonencode([{
    name      = var.container_name
    image     = var.container_image
    essential = true
    memory    = 512
    cpu       = 256
    portMappings = [
      {
        containerPort = 8443
        hostPort      = 8443
        protocol      = "tcp"
      },
    ]
  }])

  task_role_arn = aws_iam_role.ecs_task_role.arn
}

resource "aws_ecs_service" "selected" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cvist-ecs-cluster.id
  task_definition = aws_ecs_task_definition.cvist-ecs-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = 8443
  }

  depends_on = [var.lb_listener_arn]
}
