provider "aws" {
  region = "eu-west-1"
}

variable "vpc_private_subnets" {
  type    = list(string)
  default = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
}

variable "vpc_public_subnets" {
  type    = list(string)
  default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

module "vpn_gateway" {
  source = "../../"

  vpn_connection_static_routes_only         = true
  vpn_connection_static_routes_destinations = ["10.100.0.1/32", "10.200.0.1/32"]

  vpn_gateway_id      = module.vpc.vgw_id
  customer_gateway_id = aws_customer_gateway.main.id

  vpc_id                       = module.vpc.vpc_id
  vpc_subnet_route_table_ids   = module.vpc.private_route_table_ids
  vpc_subnet_route_table_count = length(var.vpc_private_subnets)

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = "169.254.33.88/30"
  tunnel2_inside_cidr   = "169.254.33.100/30"
  tunnel1_preshared_key = "1234567890abcdefghijklmn"
  tunnel2_preshared_key = "abcdefghijklmn1234567890"
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "172.83.124.11"
  type       = "ipsec.1"

  tags = {
    Name = "complete-vpn-gateway-with-static-routes"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = "complete-vpn-gateway-with-static-routes"

  cidr = "10.10.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = false

  enable_vpn_gateway = true

  tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }
}

