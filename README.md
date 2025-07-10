# Terraform AWS Infrastructure Configuration Overview

This document provides an overview of the Terraform configuration for deploying a basic AWS infrastructure, as defined in `main.tf`, `variable.tf`, and `output.tf`.

---

## Table of Contents

- [Variables](#variables)
- [Resources](#resources)
- [Outputs](#outputs)

---

## Variables

The configuration uses several variables to support multiple environments (dev, stage, prod) and to customize networking and compute resources.

| Variable Name      | Description                        | Default Value        |
|--------------------|------------------------------------|----------------------|
| default_ip         | Default IP address (CIDR)          | 0.0.0.0/0            |
| dev_region         | Region for dev environment         | us-east-1            |
| dev_az_1           | Dev environment AZ 1               | us-east-1a           |
| dev_az_2           | Dev environment AZ 2               | us-east-1c           |
| stage_region       | Region for stage environment       | ap-south-1           |
| stage_az_1         | Stage environment AZ 1             | ap-south-1a          |
| stage_az_2         | Stage environment AZ 2             | ap-south-1c          |
| prod_region        | Region for prod environment        | us-east-2            |
| prod_az_1          | Prod environment AZ 1              | us-east-2a           |
| prod_az_2          | Prod environment AZ 2              | us-east-2c           |
| vpc_cidr           | CIDR for VPC                       | 172.0.0.0/16         |
| az_1_sub           | Subnet for AZ 1                    | 172.0.0.0/24         |
| az_2_sub           | Subnet for AZ 2                    | 172.0.1.0/24         |
| instance_type      | EC2 instance type                  | t2.micro             |
| app-1_userdata     | User data for app-1 EC2            | Installs Apache, etc.|
| app-2_userdata     | User data for app-2 EC2            | Installs Apache, etc.|
| lb_type            | Load balancer type                 | application          |
| lb_internal        | Load balancer internal status      | false                |

---

## Resources

The main resources provisioned are:

- **VPC**: Creates a dedicated Virtual Private Cloud.
- **Subnets**: Two subnets, one in each availability zone.
- **Internet Gateway**: Provides internet access to the VPC.
- **Route Table & Associations**: Configures routing for subnets.
- **Security Group**: Allows all ingress and egress traffic (for demo purposes).
- **Network Interfaces**: One for each EC2 instance.
- **Elastic IPs**: Public IPs for each EC2 instance.
- **Key Pair**: SSH key for EC2 access.
- **AMI Data Source**: Fetches the latest Amazon Linux 2 AMI.
- **EC2 Instances**: Two instances, each with its own user data and network interface.
- **Load Balancer (ALB)**: Application Load Balancer spanning both subnets.
- **Target Groups & Attachments**: Each app instance is registered to its own target group.
- **Listener & Rules**: Routes `/app1` and `/app2` paths to the respective target groups.

---

## Outputs

After applying the configuration, the following outputs are available:

| Output Name         | Description                   |
|---------------------|-------------------------------|
| vpc_id              | VPC ID                        |
| app-1_subnet_id     | App 1 subnet ID               |
| app-2_subnet_id     | App 2 subnet ID               |
| app-1_private_ip    | App 1 private IP              |
| app-2_private_ip    | App 2 private IP              |
| app-1_public_ip     | App 1 public IP               |
| app-2_public_ip     | App 2 public IP               |
| IGW_id              | Internet Gateway ID           |
| rt_id               | Route Table ID                |
| sg_id               | Security Group ID             |
| app-1_enic_id       | App 1 ENI ID                  |
| app-2_enic_id       | App 2 ENI ID                  |
| app-1_eip_id        | App 1 EIP ID                  |
| app-2_eip_id        | App 2 EIP ID                  |
| keypair_id          | Key Pair ID                   |
| keypair_public_key  | Key Pair Public Key           |
| ami_id              | AMI ID                        |
| ec2_app-1_id        | EC2 App 1 ID                  |
| ec2_app-2_id        | EC2 App 2 ID                  |
| alb_arn             | Load Balancer ARN             |
| alb_dns_name        | Load Balancer DNS Name        |
| app-1_tg_arn        | App 1 Target Group ARN        |
| app-2_tg_arn        | App 2 Target Group ARN        |
| lb_listener_arn     | Load Balancer Listener ARN    |

---

## Notes

- The configuration supports multiple environments using Terraform workspaces.
- Security group rules are open for demonstration; restrict them for production.
- User data scripts install Apache and serve a welcome page for each app.