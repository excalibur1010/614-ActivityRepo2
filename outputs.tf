output "ec2_public_ip" {
  description = "Public IP of WordPress EC2 instance"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
}
