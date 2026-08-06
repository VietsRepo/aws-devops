provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "key-pair" {
  public_key = file(var.pub_key_path)
}

module "security" {
  source        = "./modules/security"
  inbound_range = var.inbound_range
}

module "compute" {
  source             = "./modules/compute"
  key_name           = aws_key_pair.key-pair.key_name
  security_group_ids = [module.security.security_group_id]
}

