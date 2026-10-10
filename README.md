# Northstar Cloud Platform

Production-grade AWS infrastructure for deploying and operating containerized microservices in a secure, scalable, and observable environment.

## Overview

Northstar Cloud Platform is a portfolio-grade AWS project that demonstrates how to build a resilient production platform using Terraform. The infrastructure provisions:

- a multi-AZ VPC with public and private subnets, with per-AZ NAT gateways in prod
- an Application Load Balancer for routing traffic
- an ECS cluster running containerized services on Amazon Linux 2023 EC2 instances
- an encrypted RDS PostgreSQL instance with credentials managed in AWS Secrets Manager
- CloudWatch logs and alarms with SNS notifications for observability
- least-privilege IAM and security group boundaries
- remote Terraform state in S3 with DynamoDB locking, separated per environment
- GitHub Actions workflows for safe Terraform plan/apply automation

## Architecture Summary

```text
Internet
   |
   v
Application Load Balancer
   |
   v
ECS Cluster (EC2 launch type, private subnets)
   |-- app service (northstar-api container)
   |
   +--> RDS PostgreSQL (credentials in Secrets Manager)
   |
   +--> CloudWatch Logs / Metrics / Alarms --> SNS alerts
```

## Why This Project Matters

This project is designed to look and behave like a client delivery. It shows:

- real-world AWS platform design
- production-oriented security boundaries
- multi-environment infrastructure deployment
- deployment automation through GitHub Actions
- operational monitoring and alerting

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml
│       └── terraform-apply.yml
├── docs/
│   └── ARCHITECTURE.md
├── environments/
│   ├── dev/
│   │   ├── backend.hcl
│   │   └── terraform.tfvars
│   └── prod/
│       ├── backend.hcl
│       └── terraform.tfvars
├── .gitignore
├── README.md
├── ecs.tf
├── load_balancer.tf
├── monitoring.tf
├── outputs.tf
├── rds.tf
├── security_groups.tf
├── variables.tf
├── versions.tf
└── vpc.tf
```

All `.tf` files live in the repository root because Terraform only loads configuration from the directory it runs in.

## Prerequisites

Before deploying, ensure you have:

- an AWS account
- AWS CLI configured locally
- Terraform 1.5+
- permission to create VPC, ECS, RDS, IAM, CloudWatch, SNS, and Secrets Manager resources
- an S3 bucket and a DynamoDB table (partition key `LockID`, type String) for Terraform state
- a GitHub Actions OIDC role configured for AWS if you want automated deployment

## Quick Start

### 1. Configure environment values

Set your state bucket and lock table names in the backend file, then review the environment values:

```bash
# Dev
vim environments/dev/backend.hcl
vim environments/dev/terraform.tfvars
```

### 2. Initialize Terraform

```bash
terraform init -backend-config=environments/dev/backend.hcl
```

To switch environments later, re-run init with `-reconfigure` and the other backend file.

### 3. Validate the configuration

```bash
terraform validate
```

### 4. Plan the deployment

```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

### 5. Apply the deployment

```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

### 6. Retrieve the database credentials

RDS generates the master password and stores it in Secrets Manager:

```bash
aws secretsmanager get-secret-value --secret-id "$(terraform output -raw rds_master_secret_arn)"
```

## CI/CD

- **Pull requests** run `fmt`, `validate`, and `plan` for both dev and prod.
- **Merges to `main`** apply dev first, then prod. Add required reviewers to the `prod` environment in the GitHub repository settings so prod waits for approval.

## Production Notes

- Prod has RDS deletion protection on and takes a final snapshot on delete. To destroy prod, turn off `deletion_protection` first.
- Set `alert_email` in the tfvars to receive alarm notifications (confirm the subscription email AWS sends).
- Commit `.terraform.lock.hcl` after the first `terraform init` so provider versions stay pinned.
- Add ACM and HTTPS termination for a real public-facing deployment
- Add a custom domain and DNS records
- Harden database configuration and IAM rules further for production workloads

## Recommended Next Enhancements

- Add ECS task definitions for real microservices
- Add ECR image build and push workflow
- Inject the Secrets Manager DB credentials into application containers
- Add private service discovery for inter-service communication
- Add a proper HTTPS listener with ACM and CloudFront
- Add a deployment pipeline for application containers

## Project Goals

This project is intentionally designed to read like a polished client deliverable and to showcase skills in:

- Terraform and AWS IaC
- networking and security design
- load balancing and high availability
- scalable container orchestration on ECS
- cloud observability and alarms
- CI/CD and production deployment readiness
