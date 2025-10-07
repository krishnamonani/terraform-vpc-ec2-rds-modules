terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.vpc_config.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_config = var.vpc_config
}

module "ec2" {
  source = "./modules/ec2"
  ec2_config = var.ec2_config
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_ids[0]
}

module "rds" {
  source = "./modules/rds"
  rds_config = var.rds_config
  subnet_ids  = module.vpc.private_subnet_ids
  vpc_id      = module.vpc.vpc_id
  ec2_security_group_id = module.ec2.security_group_id
}
