variable "vpc_id" {
  description = "VPC ID for route table"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID for routing"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID to associate with route table"
  type        = string
}
