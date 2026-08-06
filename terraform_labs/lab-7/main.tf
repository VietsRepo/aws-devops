provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "./modules/networking"
}