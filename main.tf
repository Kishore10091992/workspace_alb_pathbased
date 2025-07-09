terraform {
 required_providers {
  aws = {
   source = "hashicorp/aws"
   version = "~>5.0"
  }
 }
}

locals {
 region_map {
  dev = var.dev_region
  stage = var.stage_region
  prod = var.prod_region
 }
 
 az_1_map {
  dev = var.dev_az_1
  stage = var.stage_az_1
  prod = var.prod_az_1
 }
 
 az_2_map {
  dev = var.dev_az_2
  stage = var.stage_az_2
  prod = var.prod_az_2
 }
}

provider "aws" {
 profile = terraform.workspace
 region = lookup(local.region_map, terraform.workspace, var.dev_region)
}

resource "aws_vpc" "main_vpc" {
 vpc_cidr = var.vpc_cidr
 
 tags {
  Name = "vpc-${terraform.workspace}"
 }
}

resource "aws_subnet" "main_subnet_1" {
 vpc_id = aws_vpc.main_vpc.id
 availability_zone = lookup(local.az_1_map, terraform.workspace, var.dev_az_1)
 cidr_block = var.az_1_sub
 
 tags {
  Name = "subnet_1-${terraform.workspace}"
 }
}

resource "aws_subnet" "main_subnet_2" {
 vpc_id = aws_vpc.main_vpc.id
 availability_zone = lookup(local.az_2_map, terraform.workspace, var.dev_az_2)
 cidr_block = var.az_2_sub
 
 tags {
  Name = "subnet_2-${terraform.workspace}"
 }
}

resource "aws_internet_gateway" "main_IGW" {
 vpc_id = aws_vpc.main_vpc.id
 
 tags {
  Name = "IGW-${terraform.workspace}"
 }
}

resource "aws_route_table" "main_rt" {
 vpc_id = aws_vpc.main_vpc.id
 
 route {
  gateway_id = aws_internet_gateway.main_IGW.id
  cidr_block = var.default_ip
 }
 
 tags {
  Name = "rt-${terraform.workspace}"
 }
}

resource "aws_route_table_association" "main_sub-1_ass" {
 route_table_id = aws_route_table.main_rt.id
 subnet_id = aws_subnet.main_subnet_1.id
}

resource "aws_route_table_association" "main_sub-2_ass" {
 route_table_id = aws_route_table.main_rt.id
 subnet_id = aws_subnet.main_subnet_2.id
}

resource "aws_security_group" "main_sg" {
 vpc_id = aws_vpc.main_vpc.id
 
 ingress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_block = var.default_ip
 }
 
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_block = var.default_ip
 }
 
 tags {
  Name = "sg-${terraform.workspace}"
 }
}

resource "aws_network_interface" "main_ec2-1" {
 subnet_id = aws_subnet.main_subnet_1.id
 security_groups = [aws_security_group.main_sg.id]
}

resource "aws_network_interface" "main_ec2-2" {
 subnet_id = aws_subnet.main_subnet_2.id
 security_groups = [aws_security_group.main_sg.id]
}

resource "tls_private_key" "generate_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "main_key" {
  key_name   = "main_key"
  public_key = tls_private_key.generate_key.public_key_openssh
  
  tags {
   Name = "keypair-${terraform.workspace}"
  }
}
