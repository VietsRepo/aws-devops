provider "aws" {
  region = var.region
}

resource "aws_security_group" "hello_security_group" {
  vpc_id = var.vpc_id

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