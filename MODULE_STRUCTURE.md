# MODULE STRUCTURE

## 6 Terraform Modules (Meets Minimum Requirement)

```
Root Module (main.tf)
│
├── Module 1: VPC
│   ├── Creates VPC (10.0.0.0/16)
│   ├── Creates Public Subnet (10.0.1.0/24)
│   └── Creates Private Subnet (10.0.2.0/24)
│
├── Module 2: Internet Gateway
│   └── Creates and attaches Internet Gateway to VPC
│
├── Module 3: Route Table
│   ├── Creates Public Route Table
│   ├── Adds route to Internet Gateway
│   └── Associates Public Subnet with Route Table
│
├── Module 4: Security Groups
│   ├── EC2 Security Group (HTTP:80, SSH:22)
│   └── RDS Security Group (MySQL:3306 from EC2 only)
│
├── Module 5: RDS
│   ├── Creates DB Subnet Group
│   └── Creates MySQL RDS Instance (db.t3.micro)
│
└── Module 6: EC2
    ├── Fetches Amazon Linux 2023 AMI
    ├── Creates EC2 Instance (t2.micro)
    └── Runs wp_rds_install.sh with database config
```

## Module Dependencies

```
vpc
 ├─> internet_gateway (needs vpc_id)
 ├─> route_table (needs vpc_id, public_subnet_id)
 ├─> security_groups (needs vpc_id)
 └─> rds (needs subnet_ids)
 └─> ec2 (needs public_subnet_id)

internet_gateway
 └─> route_table (needs igw_id)

security_groups
 ├─> rds (needs rds_sg_id)
 └─> ec2 (needs ec2_sg_id)

rds
 └─> ec2 (needs db_endpoint)
```

## Data Flow

```
User Input (terraform.tfvars)
 ├─> db_username (sensitive) ─┐
 ├─> db_password (sensitive) ─┼─> RDS Module ─> Creates Database
 └─> key_name (sensitive) ────┘
                               │
                               └─> EC2 Module ─> templatefile() ─> wp_rds_install.sh
                                                                     ├─> db_host
                                                                     ├─> db_name  
                                                                     ├─> db_user
                                                                     └─> db_password
```

## Assignment Requirements Coverage

✅ **Requirement 1: Minimum 6 Modules**
   - vpc
   - internet_gateway
   - route_table
   - security_groups
   - rds
   - ec2

✅ **Requirement 2: Sensitive Variables**
   - All sensitive vars marked with `sensitive = true`
   - Stored in separate terraform.tfvars file
   - Passed with `-var-file="terraform.tfvars"`

✅ **Requirement 3: Variables to Script**
   - Using `templatefile()` function
   - Passing 4 variables to wp_rds_install.sh:
     * db_host (RDS endpoint)
     * db_name (wordpressdb)
     * db_user (from terraform.tfvars)
     * db_password (from terraform.tfvars)
