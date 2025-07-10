output "vpc_id" {
 description = "vpc id"
 value = aws_vpc.main_vpc.id
}

output "app-1_subnet_id" {
 description = "app 1 subnet id"
 value = aws_subnet.main_subnet_1.id
}

output "app-2_subnet_id" {
 description = "app 2 subnet id"
 value = aws_subnet.main_subnet_2.id
}

output "app-1_private_ip" {
 description = "app 1 private ip"
 value = aws_network_interface.main_ec2-1.private_ip
}

output "app-2_private_ip" {
 description = "app 2 private ip"
 value = aws_network_interface.main_ec2-2.private_ip
}

output "app-1_public_ip" {
 description = "app 1 public ip"
 value = aws_eip.main_app-1_eip.public_ip
}

output "app-2_public_ip" {
 description = "app 2 public ip"
 value = aws_eip.main_app-2_eip.public_ip
}

output "IGW_id" {
 description = "internet gateway id"
 value = aws_internet_gateway.main_IGW.id
}

output "rt_id" {
 description = "route table id"
 value = aws_route_table.main_rt.id
}

output "sg_id" {
 description = "security group id"
 value = aws_security_group.main_sg.id
}

output "app-1_enic_id" {
 description = "app 1 enic id"
 value = aws_network_interface.main_ec2-1.id
}

output "app-2_enic_id" {
 description = "app 2 enic id"
 value = aws_network_interface.main_ec2-2.id
}

output "app-1_eip_id" {
 description = "app 1 eip id"
 value = aws_eip.main_app-1_eip.id
}

output "app-2_eip_id" {
 description = "app 2 eip id"
 value = aws_eip.main_app-2_eip.id
}

output "keypair_id" {
 description = "keypair id"
 value = aws_key_pair.main_key.id
}

output "keypair_public_key" {
 description = "keypair public key"
 value = aws_key_pair.main_key.public_key
}

output "ami_id" {
 description = "ami id"
 value = data.aws_ami.main_amzn_linx.id
}

output "ec2_app-1_id" {
 description = "ec2 app 1 id"
 value = aws_instance.main_app-1.id
}

output "ec2_app-2_id" {
 description = "ec2 app 2 id"
 value = aws_instance.main_app-2.id
}

