output "ec2_sg_id" {
  description = "ID of EC2 security group"
  value       = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  description = "ID of RDS security group"
  value       = aws_security_group.rds_sg.id
}
