provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id = var.public_subnet_id

  tags = {
    Name = "ec2_created_by_terraform"
  }
}