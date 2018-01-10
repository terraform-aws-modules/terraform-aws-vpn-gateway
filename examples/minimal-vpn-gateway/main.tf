module "vpn_gateway" {
  source = "../../"

  create_vpn_connection = false

  vpn_gateway_id             = "${module.vpc.vgw_id}"
  customer_gateway_id        = "${aws_customer_gateway.main.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  vpc_subnet_route_table_ids = ["${module.vpc.private_route_table_ids}"]
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "172.83.124.10"
  type       = "ipsec.1"

  tags {
    Name = "main-customer-gateway"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "complete-example"

  cidr = "10.10.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

  enable_vpn_gateway = true

  tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }
}
