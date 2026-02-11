# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
  
  tags = {
    Name = "WordPress Public Route Table"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_rta" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public_rt.id
}
