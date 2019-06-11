provider "aws" {
  region = "eu-west-1"
}

variable "vpc_private_subnets" {
  type    = list(string)
  default = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
}

module "vpn_gateway" {
  source = "../../"

  create_vpn_connection = false

  vpn_gateway_id      = module.vpc.vgw_id
  customer_gateway_id = aws_customer_gateway.main.id

  vpc_id                       = module.vpc.vpc_id
  vpc_subnet_route_table_ids   = module.vpc.private_route_table_ids
  vpc_subnet_route_table_count = length(var.vpc_private_subnets)
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "172.83.124.12"
  type       = "ipsec.1"

  tags = {
    Name = "minimal-vpn-gateway"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = "minimal-vpn-gateway"

  cidr = "10.10.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnets = var.vpc_private_subnets

  enable_nat_gateway = false

  enable_vpn_gateway = true

  tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }
}

