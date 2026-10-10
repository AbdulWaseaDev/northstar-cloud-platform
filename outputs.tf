output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Application Load Balancer zone ID"
  value       = aws_lb.main.zone_id
}

output "ecs_cluster_name" {
  description = "ECS Cluster name"
  value       = aws_ecs_cluster.main.name
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.main.address
}

output "rds_port" {
  description = "RDS port"
  value       = aws_db_instance.main.port
}

output "rds_master_secret_arn" {
  description = "Secrets Manager ARN holding the RDS master credentials"
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
}

output "alerts_topic_arn" {
  description = "SNS topic that receives CloudWatch alarm notifications"
  value       = aws_sns_topic.alerts.arn
}
