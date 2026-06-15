provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
  cidr              = var.vpc_cidr
  public_cidr       = var.public_subnet_cidr
  private_cidr      = var.private_subnet_cidr
  public_subnet_az  = var.public_subnet_az
  private_subnet_az = var.private_subnet_az
  route_table_cidr  = var.route_table_cidr
}

module "compute" {
  source        = "./modules/compute"
  vpc_id        = module.networking.custom_vpc_id
  subnet_id     = module.networking.public_subnet_id
  ami_id        = var.ami_id
  instance_type_id = var.instance_type_id
}

module "monitoring" {
  source                   = "./modules/monitoring"
  email_id                 = var.email_id
  instance_id              = module.compute.instance_id
  threshold_value          = var.threshold_value
  period_value             = var.period_value
  evaluation_periods_value = var.evaluation_periods_value
}