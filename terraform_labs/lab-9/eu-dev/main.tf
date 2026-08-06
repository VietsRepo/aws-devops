provider "aws" {
  region = var.region
}

resource "aws_key_pair" "key-pair" {
  public_key = file(var.pub_key_path)
}

module "networking" {
  source = "../modules/networking"
  region = var.region
  az_1   = var.az_1
  az_2   = var.az_2
}

module "security" {
  source        = "../modules/security"
  region        = var.region
  vpc_id        = module.networking.vpc_id
  inbound_range = var.inbound_range
}

module "compute" {
  source             = "../modules/compute"
  region             = var.region
  ami_id             = var.ami_ids[var.region]
  key_name           = aws_key_pair.key-pair.key_name
  security_group_ids = [module.security.security_group_id]
  public_subnet_id   = module.networking.public_subnet_id
}