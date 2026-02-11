output "public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.wordpress_ec2.public_ip
}

output "instance_id" {
  description = "ID of EC2 instance"
  value       = aws_instance.wordpress_ec2.id
}
