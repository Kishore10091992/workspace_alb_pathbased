variable "default_ip" {
 description = "default ip address"
 type = string
 default = "0.0.0.0/0"
}

variable "dev_region" {
 description = "region for dev env"
 type = string
 default = "us-east-1"
}

variable "dev_az_1" {
 description = "dev env az 1"
 type = string
 default = "us-east-1a"
}

variable "dev_az_2" {
 description = "dev ev az 2"
 type = string
 default = "us-east-1c"
}

variable "stage_region" {
 description = "region for stage env"
 type = string
 default = "ap-south-1"
}

variable "stage_az_1" {
 description = "stage env az 1"
 type = string
 default = "ap-south-1a"
}

variable "stage_az_2" {
 description = "stage ev az 2"
 type = string
 default = "ap-south-1c"
}

variable "prod_region" {
 description = "region for prod env"
 type = string
 default = "us-east-2"
}

variable "prod_az_1" {
 description = "prod env az 1"
 type = string
 default = "us-east-2a"
}

variable "prod_az_2" {
 description = "prod ev az 2"
 type = string
 default = "us-east-2c"
}

variable "vpc_cidr" {
 description = "cidr for vpc"
 type = string
 default = "172.0.0.0/16"
}
variable "az_1_sub" {
 description = "subnet for availability zone 1"
 type = string
 default = "172.0.0.0/24"
}

variable "az_2_sub" {
 description = "subnet for availability zone 2"
 type = string
 default = "172.0.1.0/24"
}

variable "instance_type" {
 description = "instance type for ec2"
 type = string
 default = "t2.micro"
}

variable "app-1_userdata" {
description = "userdata for app-1 ec2"
type = string
default = <<-EOF
          #!/bin/bash
          yum update -y
          yum install -y httpd
          systemctl start httpd
          systemctl enable httpd
          echo "<h1>welcome to app-1<h1>" > /var/www/html/index.html
          EOF
}

variable "app-2_userdata" {
description = "userdata for app-2 ec2"
type = string
default = <<-EOF
          #!/bin/bash
          yum update -y
          yum install -y httpd
          systemctl start httpd
          systemctl enable httpd
          echo "<h1>welcome to app-2<h1>" > /var/www/html/index.html
          EOF
}

variable "lb_type" {
 description = "loadbalancer type"
 type = string
 default = "application"
}

variable "lb_internal"
 description = loadbalancer internal status"
 type = bool
 default = "false"
}
