# Provider Configuration
provider "aws" {
  region = var.aws_region
}

# Module 1: VPC and Subnets
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# Module 2: Internet Gateway
module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
}

# Module 3: Route Table
module "route_table" {
  source = "./modules/route_table"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.igw_id
  public_subnet_id    = module.vpc.public_subnet_id
}

# Module 4: Security Groups
module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

# Module 5: RDS Database
module "rds" {
  source = "./modules/rds"

  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  rds_security_group_id  = module.security_groups.rds_sg_id
  private_subnet_id      = module.vpc.private_subnet_id
  public_subnet_id       = module.vpc.public_subnet_id
}

# Module 6: EC2 Instance
module "ec2" {
  source = "./modules/ec2"

  public_subnet_id      = module.vpc.public_subnet_id
  ec2_security_group_id = module.security_groups.ec2_sg_id
  key_name              = var.key_name
  db_host               = module.rds.db_endpoint
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
}
