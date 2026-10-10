# Replace the bucket and table names with the ones you create for Terraform state.
bucket         = "northstar-terraform-state"
key            = "prod/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "northstar-terraform-locks"
encrypt        = true
