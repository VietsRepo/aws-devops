provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "key-pair" {
  public_key = file("./ssh-key-pair/key-pair.pub")
}

resource "aws_security_group" "hello_security_group" {
  tags = {
    "Name" : "hello_security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_to_access" {
  security_group_id = aws_security_group.hello_security_group.id

  cidr_ipv4   = var.inbound_range # my ip
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_to_access" {
  security_group_id = aws_security_group.hello_security_group.id

  cidr_ipv4   = var.inbound_range # my ip
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.hello_security_group.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-pair.key_name
  vpc_security_group_ids = [aws_security_group.hello_security_group.id]

  tags = {
    Name = "ec2_created_by_terraform"
  }
}