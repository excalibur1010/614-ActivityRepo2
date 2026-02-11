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

variable "rds_security_group_id" {
  description = "ID of RDS security group"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of private subnet"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of public subnet"
  type        = string
}
