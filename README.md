# AWS Cloud Infrastructure Monitoring with Terraform

A fully automated, modular, and version-controlled AWS infrastructure setup that provisions a custom network environment, a monitored EC2 instance, and an email-based alerting pipeline — all defined as code using Terraform.

## Overview

This project demonstrates a small but complete cloud infrastructure stack: a custom VPC with public/private subnets, an EC2 instance with proper IAM-based monitoring permissions, and a CloudWatch alarm that sends email notifications via SNS when CPU utilization stays high. The configuration is organized into **reusable Terraform modules** (networking, compute, monitoring), each with clearly defined inputs and outputs, following infrastructure-as-code best practices. Everything is provisioned and torn down with a single command, making the environment fully repeatable and disposable.

## Architecture

- **Custom VPC** (`10.0.0.0/16`) with a public subnet (`10.0.1.0/24`) and a private subnet (`10.0.2.0/24`)
- **Internet Gateway** attached to the VPC, with a **Route Table** routing public subnet traffic to the internet
- **EC2 instance** (`t3.micro`, free-tier eligible) launched in the public subnet with a public IP
- **Security Group** allowing inbound HTTP (80) and SSH (22) traffic, with all outbound traffic allowed
- **IAM Role + Instance Profile** attached to the EC2 instance, granting `CloudWatchAgentServerPolicy` for metric reporting
- **CloudWatch Metric Alarm** monitoring `CPUUtilization`, triggering when average CPU stays at or above a configurable threshold for a configurable evaluation window
- **SNS Topic** with an email subscription, used as the alarm's notification target

## Module Structure

The codebase is split into a root module and three child modules:

```
.
├── main.tf                      # Root - calls and wires together all modules
├── variables.tf                 # Root input variables (with sensible defaults)
├── outputs.tf                   # Root outputs (e.g. EC2 public IP)
├── terraform.tfvars.example     # Example values for sensitive/account-specific variables
├── .gitignore
└── modules/
    ├── networking/
    │   ├── main.tf               # VPC, subnets, IGW, route table, route table association
    │   ├── variables.tf          # Inputs: CIDR blocks, availability zones
    │   └── outputs.tf            # Outputs: VPC ID, public/private subnet IDs
    ├── compute/
    │   ├── main.tf               # Security Group, EC2 instance, IAM role/profile
    │   ├── variables.tf          # Inputs: vpc_id, subnet_id, ami_id, instance_type
    │   └── outputs.tf            # Outputs: instance ID, public IP
    └── monitoring/
        ├── main.tf               # SNS topic + subscription, CloudWatch alarm
        ├── variables.tf          # Inputs: instance_id, email, threshold/period/evaluation
        └── outputs.tf            # Outputs: SNS topic ARN, alarm name
```

**How modules connect:** The root module passes outputs from `networking` (VPC ID, public subnet ID) into `compute`, and the EC2 instance ID from `compute` into `monitoring` for the CloudWatch alarm's dimensions. Each module is self-contained and could be reused independently in other projects.

## Tech Stack

**Infrastructure as Code:** Terraform (modularized)
**Cloud Provider:** AWS (VPC, EC2, IAM, CloudWatch, SNS)
**Region:** ap-south-1 (Mumbai)

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS CLI installed and configured (`aws configure`) with valid credentials
- An AWS account with permissions to create VPC, EC2, IAM, CloudWatch, and SNS resources

## How to Deploy

1. Clone this repository
2. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in your values:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
   At minimum, set:
   - `email_id` — the email address that will receive CloudWatch alarm notifications
   - `ami_id` — a valid AMI ID for your target region
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Review the execution plan:
   ```bash
   terraform plan
   ```
5. Apply the configuration:
   ```bash
   terraform apply
   ```
6. **Confirm the SNS email subscription** — check your inbox for an email from AWS Notifications and click "Confirm subscription." Alerts will not be delivered until this step is completed.

## How to Tear Down

To avoid ongoing AWS charges, destroy all resources when done:

```bash
terraform destroy
```

This removes all 14 resources created by this configuration in the correct dependency order.

## Security Notes

- `terraform.tfvars` (containing the real email address and AMI ID) is excluded from version control via `.gitignore`. Only `terraform.tfvars.example` with placeholder values is committed.
- HTTP and SSH are currently open to `0.0.0.0/0` for demonstration purposes. In a production environment, SSH access should be restricted to specific trusted IP addresses.

## Future Improvements

- Add additional CloudWatch alarms (e.g. for disk I/O or network thresholds)
- Add a CloudWatch dashboard to visualize metrics alongside the alarm
- Support multiple environments (dev/prod) via separate `.tfvars` files
