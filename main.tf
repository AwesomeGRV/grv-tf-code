locals {
  global_ip                  = "0.0.0.0/0"
  avail_zone                 = ["us-east-1a", "us-east-1b"]
  private_avail_zone         = ["us-east-1c", "us-east-1d"]
  aws_region                 = var.aws_region
  dev_namespace              = "development"
  manage_namespace           = "management"
  dev_cidr                   = "10.0.0.0/16"
  manage_cidr                = "20.0.0.0/16"
  dev_subnet_cidr            = ["10.0.1.0/24", "10.0.2.0/24"]
  dev_private_subnet_cidr    = ["10.0.3.0/24", "10.0.4.0/24"]
  manage_subnet_cidr         = ["20.0.1.0/24", "20.0.2.0/24"]
  manage_private_subnet_cidr = ["20.0.3.0/24", "20.0.4.0/24"]
  prod_cidr                  = "30.0.0.0/16"
  prod_subnet_cidr           = ["30.0.1.0/24", "30.0.2.0/24"]
  prod_private_subnet_cidr   = ["30.0.3.0/24", "30.0.4.0/24"]
  prod_namespace             = "production"
  
  common_tags = {
    Environment     = "multi-vpc-setup"
    ManagedBy       = "terraform"
    Project         = "aws-networking"
    CostCenter      = "infrastructure"
    TerraformModule = "aws-multi-vpc"
  }
}

module "vpc-dev" {
  source              = "./modules/vpc"
  cidr                = local.dev_cidr
  subnet_cidr         = local.dev_subnet_cidr
  private_subnet_cidr = local.dev_private_subnet_cidr
  avail_zone          = local.avail_zone
  private_avail_zone  = local.private_avail_zone
  global_ip           = local.global_ip
  namespace           = local.dev_namespace
  tags                = merge(local.common_tags, { Environment = local.dev_namespace })
}

module "network-acls-dev" {
  source             = "./modules/network-acls"
  vpc_id            = module.vpc-dev.vpc_id
  vpc_cidr          = module.vpc-dev.vpc_cidr_block
  public_subnet_ids  = module.vpc-dev.subnet_pub
  private_subnet_ids = module.vpc-dev.subnet_pri
  namespace          = local.dev_namespace
  create_public_acl  = false
  create_private_acl = true
  allow_ssh         = false
  tags              = merge(local.common_tags, { Environment = local.dev_namespace })
}

module "vpc-dev-configs" {
  source     = "./modules/vpc-configs"
  vpc_id     = module.vpc-dev.vpc_id
  aws_region = local.aws_region
  namespace  = local.dev_namespace
  tags       = merge(local.common_tags, { Environment = local.dev_namespace })
}

module "vpc-manage" {
  source              = "./modules/vpc"
  cidr                = local.manage_cidr
  subnet_cidr         = local.manage_subnet_cidr
  private_subnet_cidr = local.manage_private_subnet_cidr
  avail_zone          = local.avail_zone
  private_avail_zone  = local.private_avail_zone
  global_ip           = local.global_ip
  namespace           = local.manage_namespace
  tags                = merge(local.common_tags, { Environment = local.manage_namespace })
}

module "network-acls-manage" {
  source             = "./modules/network-acls"
  vpc_id            = module.vpc-manage.vpc_id
  vpc_cidr          = module.vpc-manage.vpc_cidr_block
  public_subnet_ids  = module.vpc-manage.subnet_pub
  private_subnet_ids = module.vpc-manage.subnet_pri
  namespace          = local.manage_namespace
  create_public_acl  = true
  create_private_acl = true
  allow_ssh         = true
  ssh_allowed_cidr  = "0.0.0.0/0"
  tags              = merge(local.common_tags, { Environment = local.manage_namespace })
}

module "vpc-manage-configs" {
  source     = "./modules/vpc-configs"
  vpc_id     = module.vpc-manage.vpc_id
  aws_region = local.aws_region
  namespace  = local.manage_namespace
  tags       = merge(local.common_tags, { Environment = local.manage_namespace })
}

module "vpc-prod" {
  source              = "./modules/vpc"
  cidr                = local.prod_cidr
  subnet_cidr         = local.prod_subnet_cidr
  private_subnet_cidr = local.prod_private_subnet_cidr
  avail_zone          = local.avail_zone
  private_avail_zone  = local.private_avail_zone
  global_ip           = local.global_ip
  namespace           = local.prod_namespace
  tags                = merge(local.common_tags, { Environment = local.prod_namespace })
}

module "network-acls-prod" {
  source             = "./modules/network-acls"
  vpc_id            = module.vpc-prod.vpc_id
  vpc_cidr          = module.vpc-prod.vpc_cidr_block
  public_subnet_ids  = module.vpc-prod.subnet_pub
  private_subnet_ids = module.vpc-prod.subnet_pri
  namespace          = local.prod_namespace
  create_public_acl  = false
  create_private_acl = true
  allow_ssh         = false
  tags              = merge(local.common_tags, { Environment = local.prod_namespace })
}

module "vpc-prod-configs" {
  source     = "./modules/vpc-configs"
  vpc_id     = module.vpc-prod.vpc_id
  aws_region = local.aws_region
  namespace  = local.prod_namespace
  tags       = merge(local.common_tags, { Environment = local.prod_namespace })
}

module "TGW" {
  source                          = "./modules/transit-gateway"
  vpc_id_manage                   = module.vpc-manage.vpc_id
  vpc_id_dev                      = module.vpc-dev.vpc_id
  vpc_id_prod                     = module.vpc-prod.vpc_id
  subnet_dev                      = concat(module.vpc-dev.subnet_pri, module.vpc-dev.subnet_pub)
  subnet_manage                   = concat(module.vpc-manage.subnet_pub, module.vpc-manage.subnet_pri)
  subnet_prod                     = concat(module.vpc-prod.subnet_pri, module.vpc-prod.subnet_pub)
  rt_table_dev_a                  = module.vpc-dev.route_table_pri_dev[0]
  dest_dev                        = [ local.manage_cidr, local.prod_cidr ]
  rt_table_manage_a               = module.vpc-manage.route_table_pub[0]
  rt_table_manage_c               = module.vpc-manage.route_table_pri_manage[0]
  rt_table_manage_d               = module.vpc-manage.route_table_pri_manage[1]
  dest_manage                     = [ local.dev_cidr, local.prod_cidr ]
  rt_table_prod_a                 = module.vpc-prod.route_table_pri_prod[0]
  dest_prod                       = [ local.manage_cidr, local.dev_cidr ]
  tags                            = local.common_tags
}
