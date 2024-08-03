# Variables
variable "ec2_sg_ssh_http_name" {}
variable "vpc_id" {}
variable "public_subnet_cidr_block" {}
variable "ec2_sg_name_for_python_api" {}

# Outputs
output "sg_ec2_sg_ssh_http" {
  value = aws_security_group.ec2_sg_ssh_http.id
}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_mysql_sg.id
}

output "sg_ec2_for_python_api" {
  value = aws_security_group.ec2_sg_python_api.id
}

# Security Group for Jenkins EC2 instance
resource "aws_security_group" "ec2_sg_ssh_http" {
    name = var.ec2_sg_ssh_http_name
    description = "Enable the Port 22(SSH), Port 80(http) and Port 443(https)"
    vpc_id = var.vpc_id

    # ssh for terraform remote exec
    ingress {
        description = "Allow remote SSH from anywhere"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Enable HTTP
    ingress {
        description = "Allow HTTP request from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Enable HTTPS
    ingress {
        description = "Allow HTTPS request from anywhere"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #Outgoing request
    egress {
        description = "Allow outgoing request"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Security Group to allow SSH(22), HTTP(80) & HTTPS(443)"
    }
}

# Security Group for RDS
resource "aws_security_group" "rds_mysql_sg" {
    name = "rds_sg"
    description = "Allow access to RDS from EC2 present in public subnet"
    vpc_id = var.vpc_id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = var.public_subnet_cidr_block
    }
}

# Security Group for Python API
resource "aws_security_group" "ec2_sg_python_api" {
    name = var.ec2_sg_name_for_python_api
    description = "Enable the Port 5000 for python api"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow traffic on port 5000"
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Security Groups to allow traffic on port 5000"
    }
}