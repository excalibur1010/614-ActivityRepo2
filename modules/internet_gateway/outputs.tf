output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.wordpress_igw.id
}
