provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "my-repo" {
  name                 = "my-repo2"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecs_cluster" "my-cluster" {
  name = "ecs-devops-sandbox-cluster2"
}

resource "aws_ecs_task_definition" "service" {
  family = "MyTaskDefinition2"
  container_definitions = jsonencode([
    {
      name      = "MyContainerName2"
      image     = "service-first"
      cpu       = 0
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 0
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "cluster-service" {
  name            = "MyService2"
  cluster         = aws_ecs_cluster.my-cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  force_new_deployment = true
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 100
}



resource "aws_route_table" "vpc_public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_vpc" "main" {
  cidr_block       = "172.16.0.0/16"

  tags = {
    Name = "main"
  }
}



resource "aws_subnet" "my_public_subnets" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.az_in_current_region.names[count.index]
  map_public_ip_on_launch = "true"
}

data "aws_availability_zones" "az_in_current_region" {
  state                   = "available"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my new internet gateway"
  }
}