# WordPress and RDS Terraform Project

This project deploys a WordPress application with an external RDS MySQL database on AWS using Terraform modules.

## Project Structure

```
wordpress-rds-terraform/
├── main.tf                     # Root module orchestrating all 6 modules
├── variables.tf                # Root variable definitions
├── outputs.tf                  # Root outputs
├── terraform.tfvars            # Sensitive variables (DO NOT COMMIT!)
├── wp_rds_install.sh          # WordPress installation script
├── README.md                   # This file
├── QUICK_START.md             # Quick reference guide
└── modules/
    ├── vpc/                    # Module 1: VPC and subnets
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── internet_gateway/       # Module 2: Internet Gateway
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── route_table/            # Module 3: Route tables and associations
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security_groups/        # Module 4: Security groups for EC2 and RDS
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── rds/                    # Module 5: RDS MySQL database
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2/                    # Module 6: EC2 instance for WordPress
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Prerequisites

1. AWS account with appropriate permissions
2. AWS CLI configured with credentials
3. Terraform installed (version 1.0+)
4. An existing EC2 key pair in your AWS account

## Setup Instructions

### 1. Update terraform.tfvars

**IMPORTANT:** Edit `terraform.tfvars` and change the following values:

```hcl
db_username = "admin"                              # Your database username
db_password = "YourSecurePassword123!"             # CHANGE TO A SECURE PASSWORD
key_name    = "your-actual-key-pair-name"          # CHANGE TO YOUR AWS KEY PAIR NAME
```

### 2. Initialize Terraform

```bash
terraform init
```

This will download the AWS provider and initialize all 6 modules.

### 3. Plan the Infrastructure

```bash
terraform plan -var-file="terraform.tfvars"
```

**For Deliverable #1:** Take a screenshot showing sensitive variables marked as "(sensitive value)"

### 4. Apply the Configuration

```bash
terraform apply -var-file="terraform.tfvars"
```

Type `yes` when prompted.

**For Deliverable #2:** Take a screenshot of the outputs showing `ec2_public_ip` and `rds_endpoint`

### 5. Access WordPress

Wait about 5-10 minutes for the installation to complete, then:

1. Go to: `http://[your-ec2-public-ip]`
2. Select your language
3. Complete the WordPress installation

**For Deliverable #3:** Take a screenshot showing WordPress running with your public IP in the browser

## Cleanup

### Destroy All Resources

When you're done, destroy all resources to avoid charges:

```bash
terraform destroy -var-file="terraform.tfvars"
```

Type `yes` when prompted.

**Don't forget to also terminate your EC2 instance running Terraform!**

## Deliverables

1. Screenshot of `terraform plan` showing sensitive variables as "(sensitive value)"
2. Screenshot of `terraform apply` outputs showing public IP and RDS endpoint
3. Screenshot of WordPress running at your public IP
4. Zip file containing all Terraform files

## Architecture

This deployment creates:

- **VPC** with public and private subnets (Module 1)
- **Internet Gateway** for public access (Module 2)
- **Route Tables** with proper routing (Module 3)
- **Security Groups** for EC2 and RDS (Module 4)
- **RDS MySQL Database** (db.t3.micro) (Module 5)
- **EC2 Instance** running WordPress (t2.micro) (Module 6)

## Module Descriptions

### Module 1: VPC
Creates the network infrastructure including VPC, public subnet, and private subnet.

### Module 2: Internet Gateway
Creates the Internet Gateway and attaches it to the VPC for public internet access.

### Module 3: Route Table
Creates route tables and associates the public subnet with proper routing through the Internet Gateway.

### Module 4: Security Groups
Defines security rules for EC2 (HTTP, SSH) and RDS (MySQL from EC2 only).

### Module 5: RDS
Creates the MySQL database and subnet group for high availability.

### Module 6: EC2
Launches the EC2 instance and runs the WordPress installation script with database configuration.

## Variables

### Sensitive Variables (in terraform.tfvars)
- `db_username` - Database admin username
- `db_password` - Database admin password
- `key_name` - AWS EC2 key pair name

### Non-Sensitive Variables (in variables.tf)
- `aws_region` - AWS region (default: us-east-1)
- `vpc_cidr` - VPC CIDR block (default: 10.0.0.0/16)
- `public_subnet_cidr` - Public subnet CIDR (default: 10.0.1.0/24)
- `private_subnet_cidr` - Private subnet CIDR (default: 10.0.2.0/24)
- `db_name` - Database name (default: wordpressdb)

## Assignment Requirements Met

✅ **Requirement 1:** Refactored into **6 modules** for reusability:
   1. vpc
   2. internet_gateway
   3. route_table
   4. security_groups
   5. rds
   6. ec2

✅ **Requirement 2:** Sensitive variables (db_username, db_password, key_name) are:
   - Marked with `sensitive = true`
   - Stored in separate terraform.tfvars file
   - Passed as argument with `-var-file="terraform.tfvars"`

✅ **Requirement 3:** Variables properly passed to wp_rds_install.sh using templatefile():
   - db_host
   - db_name
   - db_user
   - db_password

## Security Notes

1. **Never commit terraform.tfvars to version control**
2. Use strong passwords for database
3. Consider restricting SSH access (currently open to 0.0.0.0/0)
4. RDS is only accessible from EC2 instance (not publicly accessible)

## Troubleshooting

### WordPress doesn't load
- Wait 5-10 minutes for installation to complete
- Check EC2 instance logs: `ssh -i your-key.pem ec2-user@[public-ip]`
- View installation logs: `sudo cat /var/log/cloud-init-output.log`

### Can't connect to RDS
- Ensure security groups allow EC2 to RDS communication
- Verify RDS is in "Available" state in AWS Console
- Check the endpoint in the outputs

### Terraform errors
- Ensure AWS credentials are configured
- Check that the key pair name exists in your AWS account
- Verify you have appropriate IAM permissions

## Cost Estimate

Using Free Tier:
- EC2 t2.micro: Free (750 hours/month for 12 months)
- RDS db.t3.micro: Free (750 hours/month for 12 months)
- Data transfer: Minimal costs

**Remember to destroy resources when done to avoid charges!**
