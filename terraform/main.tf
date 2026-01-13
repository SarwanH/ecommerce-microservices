module "vpc" {
  source = "./modules/vpc"
  
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

module "security_groups" {
  source = "./modules/security-groups"
  
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"
  
  project_name      = var.project_name
  subnet_ids        = module.vpc.data_subnet_ids
  security_group_id = module.security_groups.rds_security_group_id
  db_password       = var.db_password
}