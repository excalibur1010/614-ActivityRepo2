# Internet Gateway for Public Access
resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "WordPress Internet Gateway"
  }
}
