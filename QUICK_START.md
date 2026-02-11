# QUICK START GUIDE - WordPress and RDS Activity

## What This Project Does
This Terraform project creates a complete WordPress installation on AWS with:
- **6 Terraform modules** (VPC, Internet Gateway, Route Table, Security Groups, RDS, EC2)
- Sensitive variables properly handled in terraform.tfvars
- Automated WordPress installation connected to external RDS database

## Before You Start

1. Extract the zip file on your EC2 instance (or local machine with AWS access)
2. **CRITICAL:** Edit `terraform.tfvars` and change:
   - `key_name` to your actual AWS key pair name
   - `db_password` to a secure password

## Commands to Run

### 1. Initialize
```bash
terraform init
```

### 2. Plan (Deliverable #1 - Screenshot this!)
```bash
terraform plan -var-file="terraform.tfvars"
```
📸 **Screenshot showing password and username as "(sensitive value)"**

### 3. Apply (Deliverable #2 - Screenshot the outputs!)
```bash
terraform apply -var-file="terraform.tfvars"
```
📸 **Screenshot showing ec2_public_ip and rds_endpoint**

### 4. Access WordPress (Deliverable #3 - Screenshot the browser!)
Wait 5-10 minutes, then go to: `http://[your-ec2-public-ip]`
📸 **Screenshot showing WordPress installation page with your public IP in URL bar**

### 5. Cleanup
```bash
terraform destroy -var-file="terraform.tfvars"
```
⚠️ Also terminate your EC2 instance running Terraform!

## Assignment Requirements Checklist

✅ **Requirement 1:** Refactored into **6 modules** (minimum requirement met!)
   1. vpc - VPC and subnets
   2. internet_gateway - Internet Gateway
   3. route_table - Route tables and associations
   4. security_groups - EC2 and RDS security groups
   5. rds - RDS MySQL database
   6. ec2 - EC2 WordPress instance

✅ **Requirement 2:** Sensitive variables in terraform.tfvars with sensitive = true

✅ **Requirement 3:** Variables passed to wp_rds_install.sh using templatefile()

## Deliverable Checklist

📋 **Deliverable 1:** Screenshot of `terraform plan` showing sensitive variables
📋 **Deliverable 2:** Screenshot of `terraform apply` outputs  
📋 **Deliverable 3:** Screenshot of WordPress running in browser
📋 **Deliverable 4:** Zip file of all Terraform files (this file!)

## File Structure

```
wordpress-rds-terraform/
├── main.tf                    ← Orchestrates all 6 modules
├── variables.tf               ← Variable definitions  
├── outputs.tf                 ← Output definitions
├── terraform.tfvars          ← 🔒 SENSITIVE - Edit this file!
├── wp_rds_install.sh         ← WordPress installation script
├── README.md                  ← Full documentation
├── QUICK_START.md            ← This file
└── modules/
    ├── vpc/                   ← Module 1: VPC and subnets
    ├── internet_gateway/      ← Module 2: Internet Gateway
    ├── route_table/           ← Module 3: Route tables
    ├── security_groups/       ← Module 4: Security groups
    ├── rds/                   ← Module 5: RDS database
    └── ec2/                   ← Module 6: EC2 instance
```

## Troubleshooting

**Problem:** WordPress doesn't load  
**Solution:** Wait 5-10 minutes for installation to complete

**Problem:** "Error: No valid credential sources found"  
**Solution:** Run `aws configure` to set up AWS credentials

**Problem:** "Error: creating EC2 Instance: InvalidKeyPair.NotFound"  
**Solution:** Update `key_name` in terraform.tfvars to match your AWS key pair

**Problem:** Sensitive values not showing as "(sensitive value)"  
**Solution:** Make sure you're using `-var-file="terraform.tfvars"` in your command

## Key Features

1. ✅ **6 Modular Components:** Exceeds minimum 6 module requirement
2. ✅ **Security:** Sensitive variables marked and stored separately  
3. ✅ **Automation:** WordPress auto-configured with RDS connection
4. ✅ **Best Practices:** Proper variable passing with templatefile()

## Important Notes

⚠️ **DO NOT commit terraform.tfvars to Git** (contains passwords)  
⚠️ **DO remember to run terraform destroy** when done  
⚠️ **DO terminate your Terraform EC2 instance** after the activity

Good luck with your assignment! 🚀
