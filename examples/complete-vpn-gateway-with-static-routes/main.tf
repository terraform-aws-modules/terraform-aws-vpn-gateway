variable "vpc_private_subnets" {
  default = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
}

module "vpn_gateway" {
  source = "../../"

  vpn_connection_static_routes_only         = true
  vpn_connection_static_routes_destinations = ["10.100.0.1/32", "10.200.0.1/32"]

  vpn_gateway_id      = "${module.vpc.vgw_id}"
  customer_gateway_id = "${aws_customer_gateway.main.id}"

  vpc_id                       = "${module.vpc.vpc_id}"
  vpc_subnet_route_table_ids   = ["${module.vpc.private_route_table_ids}"]
  vpc_subnet_route_table_count = "${length(var.vpc_private_subnets)}"

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = "169.254.33.88/30"
  tunnel2_inside_cidr   = "169.254.33.100/30"
  tunnel1_preshared_key = "0DTiAd2&O[>pdC#qMr~#C-CL"
  tunnel2_preshared_key = "#Z15YI$_TiP*+rCaF<AD*bXu"
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "172.83.124.11"
  type       = "ipsec.1"

  tags {
    Name = "main-customer-gateway-complete-example-with-static-routes"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "complete-example-with-static-routes"

  cidr = "10.10.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["${var.vpc_private_subnets}"]

  enable_vpn_gateway = true

  tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }
}
