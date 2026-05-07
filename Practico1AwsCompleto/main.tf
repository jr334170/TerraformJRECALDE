module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  az                 = var.az
  vpc_name           = var.vpc_name
  internet_cidr      = var.internet_cidr
}

module "ec2" {
  source               = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_id            = module.vpc.public_subnet_id
  vpc_id               = module.vpc.vpc_id
  instance_name        = var.instance_name
  allowed_ssh_cidrs    = var.allowed_ssh_cidrs
  allowed_http_cidrs   = var.allowed_http_cidrs
  allowed_egress_cidrs = var.allowed_egress_cidrs
  ssh_port             = var.ssh_port
  http_port            = var.http_port
}
