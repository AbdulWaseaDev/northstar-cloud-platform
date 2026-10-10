terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Partial configuration: bucket, key, region and lock table come from
  # environments/<env>/backend.hcl so each environment keeps its own state.
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

locals {
  is_prod = var.environment == "prod"

  tags = merge({
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = "Abdul Wasea"
  }, var.tags)
}
