variable "public_subnet_id" {
  description = "ID of public subnet"
  type        = string
}

variable "ec2_security_group_id" {
  description = "ID of EC2 security group"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "RDS endpoint"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
