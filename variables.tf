variable "project_name" {
  description = "Name prefix used across infrastructure resources"
  type        = string
  default     = "northstar"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.20.11.0/24", "10.20.12.0/24"]
}

variable "single_nat_gateway" {
  description = "Use one shared NAT gateway (cheaper) instead of one per availability zone (highly available)"
  type        = bool
  default     = true
}

variable "container_image" {
  description = "Container image used by the ECS service"
  type        = string
  default     = "nginx:stable-alpine"
}

variable "container_port" {
  description = "Port the application container listens on"
  type        = number
  default     = 80
}

variable "app_desired_count" {
  description = "Desired number of tasks in the ECS service"
  type        = number
  default     = 2
}

variable "db_username" {
  description = "RDS master username. The password is generated and stored in Secrets Manager by RDS."
  type        = string
  default     = "northstaradmin"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_multi_az" {
  description = "Run RDS with a standby replica in a second availability zone"
  type        = bool
  default     = false
}

variable "ecs_instance_type" {
  description = "EC2 instance type for the ECS cluster. With awsvpc networking, a t3.small fits two tasks per instance."
  type        = string
  default     = "t3.small"
}

variable "ecs_desired_capacity" {
  description = "Desired EC2 capacity in the ASG"
  type        = number
  default     = 2
}

variable "ecs_min_capacity" {
  description = "Minimum EC2 capacity in the ASG"
  type        = number
  default     = 1
}

variable "ecs_max_capacity" {
  description = "Maximum EC2 capacity in the ASG"
  type        = number
  default     = 3
}

variable "alert_email" {
  description = "Email address subscribed to the alerts SNS topic. Leave empty to skip the subscription."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional AWS resource tags"
  type        = map(string)
  default     = {}
}
