# terraform-aws-vpn-gateway

Terraform module which creates VPN gateway resources on AWS.
This module creates:
* a [VPN Connection](https://www.terraform.io/docs/providers/aws/r/vpn_connection.html) unless `create_vpn_connection = false`
* a [VPN Gateway Attachment](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_attachment.html)
* one or more [VPN Gateway Route Propagation](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html) depending on how many routing tables exists in a VPC
* one or more [VPN Connection Route](https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html) if `create_vpn_connection = true` and depending on the number of destinations provided in variable `vpn_connection_static_routes_destinations`

This module does not create a [VPN Gateway](https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html) resource because it is meant to be used in combination with the [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) that will create that resource (when `enable_vpn_gateway = true`).
This module also does not create a [Customer Gateway](https://www.terraform.io/docs/providers/aws/r/customer_gateway.html) resource.
This module will create static routes for the VPN Connection if configured to create a VPN Connection resource with static routes and destinations for the routes have been provided.

Usage
-----

## With VPC module

```hcl
provider "aws" {
  version = "~> 1.0.0"
  region  = "eu-west-1"
}

module "vpn_gateway" {
  source = "terraform-aws-modules/vpn-gateway/aws"

  vpn_gateway_id      = "${module.vpc.vgw_id}"
  customer_gateway_id = "${aws_customer_gateway.main.id}"
  vpc_id              = "${module.vpc.vpc_id}"
  vpc_subnet_ids      = ["${module.vpc.private_route_table_ids}"]
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

  enable_vpn_gateway = true

  ...
}
```

## Without VPC module

```hcl
provider "aws" {
  version = "~> 1.0.0"
  region  = "eu-west-1"
}

module "vpn_gateway" {
  source = "terraform-aws-modules/vpn-gateway/aws"

  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.main.id}"
  vpc_id              = "${aws_vpc.vpc.vpc_id}"
  vpc_subnet_ids      = ["${aws_subnet.*.id}"]
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "172.83.124.10"
  type       = "ipsec.1"

  tags {
    Name = "main-customer-gateway"
  }
}

resource "aws_vpc" "vpc" {
  ...
}

resource "aws_subnet" "one" {
  vpc_id = "${aws_vpc.vpc.vpc_id}"

  ...
}

resource "aws_subnet" "two" {
  vpc_id = "${aws_vpc.vpc.vpc_id}"

  ...
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = "${aws_vpc.vpc.vpc_id}"

  ...
}
```
