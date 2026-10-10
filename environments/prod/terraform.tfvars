project_name = "northstar"
environment  = "prod"
aws_region   = "us-east-1"

vpc_cidr             = "10.20.0.0/16"
public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
single_nat_gateway   = false

container_image   = "nginx:stable-alpine"
container_port    = 80
app_desired_count = 3

db_username       = "northstaradmin"
db_instance_class = "db.t3.micro"
db_multi_az       = true

# t3.small fits two awsvpc tasks per instance: 3 instances leave room for
# 3 running tasks plus their replacements during a rolling deployment.
ecs_instance_type    = "t3.small"
ecs_desired_capacity = 3
ecs_min_capacity     = 2
ecs_max_capacity     = 4

alert_email = ""
