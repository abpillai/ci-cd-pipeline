provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
  }
  backend "s3" {
    bucket = "terra-centralrepo-me-central-1"
    key    = "key/prod_terraform.tfstate"
    region = "me-central-1"
  }
}

resource "aws_instance" "data-service" {

  ami = var.ami
  instance_type = var.instance_type

  key_name = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.prod_sg.id]
  associate_public_ip_address = true
  ebs_optimized = true

  tags = {
    Name = "prod-data-service"
    Terraform   = "true"
    Environment = "production"
  }
}

resource "aws_security_group" "prod_sg" {
  name        = "prod_sg"
  description = "Security group for prod environment"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_dns" {
  value = aws_instance.data-service.public_dns
}