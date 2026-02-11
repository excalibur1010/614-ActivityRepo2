output "db_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.wordpress_db.endpoint
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.wordpress_db.db_name
}
