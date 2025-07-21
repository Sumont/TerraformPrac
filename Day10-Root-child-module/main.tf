module "vpc" {
  source         = "./modules/vpc"
  cidr_block     = var.vpc_cidr_block
  subnet_cidr_1  = var.subnet_cidr_1
  subnet_cidr_2  = var.subnet_cidr_2
  az_1           = var.availability_zone_1
  az_2           = var.availability_zone_2
}

module "rds" {
  source         = "./modules/rds"
  subnet_ids     = module.vpc.subnet_ids
  instance_class = var.rds_instance_class
  db_name        = var.rds_db_name
  db_user        = var.rds_db_user
  db_password    = var.rds_db_password
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = module.vpc.subnet_ids[0]  
}

