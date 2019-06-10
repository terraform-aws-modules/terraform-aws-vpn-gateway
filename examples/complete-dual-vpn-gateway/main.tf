provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = ">= 0.12"
}

module "vpn_gateway" {
  source = "../../"

  vpn_gateway_id      = module.vpc.vgw_id
  customer_gateway_id = aws_customer_gateway.main.id

  tunnel1_inside_cidr           = "169.254.33.88/30"
  tunnel2_inside_cidr           = "169.254.33.100/30"
  vpc_id                        = module.vpc.vpc_id
  create_vpn_gateway_attachment = false
}

module "vpn_gateway2" {
  source = "../../"

  vpn_gateway_id      = module.vpc.vgw_id
  customer_gateway_id = aws_customer_gateway.secondary.id

  tunnel1_inside_cidr           = "169.254.34.88/30"
  tunnel2_inside_cidr           = "169.254.34.100/30"
  vpc_id                        = module.vpc.vpc_id
  create_vpn_gateway_attachment = false
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "213.180.157.201"
  type       = "ipsec.1"

  tags = {
    Name = "main-customer-gateway-complete-example"
  }
}

resource "aws_customer_gateway" "secondary" {
  bgp_asn    = 65000
  ip_address = "213.180.157.202"
  type       = "ipsec.1"

  tags = {
    Name = "main-customer-gateway-complete-example"
  }
}

module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git"

  name = "complete-example"

  cidr = "10.10.0.0/16"

  azs              = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets   = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
  redshift_subnets = ["10.10.21.0/24", "10.10.22.0/24", "10.10.23.0/24"]
  intra_subnets    = ["10.10.31.0/24", "10.10.32.0/24", "10.10.33.0/24"]
  database_subnets = ["10.10.41.0/24", "10.10.42.0/24", "10.10.43.0/24"]

  #create vGW and set route propagation only for private networks
  enable_vpn_gateway                 = true
  propagate_private_route_tables_vgw = false
  propagate_public_route_tables_vgw  = true

  tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }
}

