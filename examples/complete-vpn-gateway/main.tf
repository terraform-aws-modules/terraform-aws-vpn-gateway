provider "aws" {
  region = "eu-west-1"
}

module "vpn_gateway" {
  source = "../../"

  vpn_gateway_id      = module.vpc.vgw_id
  customer_gateway_id = aws_customer_gateway.main.id

  vpc_id                       = module.vpc.vpc_id
  vpc_subnet_route_table_ids   = module.vpc.private_route_table_ids
  vpc_subnet_route_table_count = length(var.vpc_private_subnets)
  local_ipv4_network_cidr      = "0.0.0.0/0"
  remote_ipv4_network_cidr     = module.vpc.vpc_cidr_block

  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key
  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr

  tunnel1_log_options = {
    cloudwatch_log_options = {
      log_enabled       = true
      log_group_arn     = aws_cloudwatch_log_group.tunnel1_logs.arn
      log_output_format = "text"
    }
  }
  tunnel2_log_options = {
    cloudwatch_log_options = {
      log_enabled       = true
      log_group_arn     = aws_cloudwatch_log_group.tunnel2_logs.arn
      log_output_format = "text"
    }
  }
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "172.83.124.10"
  type       = "ipsec.1"

  tags = {
    Name = "complete-vpn-gateway"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "complete-vpn-gateway"

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

resource "aws_cloudwatch_log_group" "tunnel1_logs" {
  name              = "complete-vpn-tunnel1-logs"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "tunnel2_logs" {
  name              = "complete-vpn-tunnel2-logs"
  retention_in_days = 7
}
