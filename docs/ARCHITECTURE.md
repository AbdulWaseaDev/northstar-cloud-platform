# Northstar Cloud Platform

This project provisions a production-grade AWS microservices platform using Terraform.

## Architecture

- VPC with public and private subnets spread across multiple availability zones
- NAT gateways for private subnet egress (one shared in dev, one per AZ in prod)
- Application Load Balancer for incoming traffic
- ECS cluster running containerized workloads on Amazon Linux 2023 EC2 instances
- RDS PostgreSQL database with encrypted storage and credentials managed in Secrets Manager
- CloudWatch alarms that notify an SNS topic
- Security groups that only allow ALB → ECS → RDS traffic, and scoped IAM roles

## State

Each environment keeps its own Terraform state in S3 (`dev/terraform.tfstate`, `prod/terraform.tfstate`), locked with DynamoDB. Backend settings live in `environments/<env>/backend.hcl`.

## Deployment

1. Configure AWS credentials.
2. Review the environment values in `environments/dev/terraform.tfvars` or `environments/prod/terraform.tfvars`.
3. Run:

```bash
terraform init -backend-config=environments/dev/backend.hcl
terraform plan -var-file=environments/dev/terraform.tfvars
terraform apply -var-file=environments/dev/terraform.tfvars
```
