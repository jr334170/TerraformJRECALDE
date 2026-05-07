module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  vpc_name           = var.vpc_name
  internet_cidr      = var.internet_cidr
}

module "alb" {
  source             = "./modules/alb"
  name               = var.asg_name
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  allowed_http_cidrs = var.allowed_http_cidrs
}

module "compute" {
  source                = "./modules/compute"
  name                  = var.asg_name
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.public_subnet_ids
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  target_group_arns     = [module.alb.target_group_arn]
  alb_security_group_id = module.alb.security_group_id
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  allowed_ssh_cidrs     = var.allowed_ssh_cidrs
  allowed_egress_cidrs  = var.allowed_egress_cidrs
  db_host     = module.rds.endpoint
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

module "rds" {
  source                = "./modules/rds"
  name                  = var.asg_name
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  instance_class        = var.db_instance_class
  app_security_group_id = module.compute.security_group_id
}
