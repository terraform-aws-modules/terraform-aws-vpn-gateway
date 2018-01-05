# terraform-aws-vpn-gateway

Terraform module which creates VPN gateway resources on AWS.
This module creates:
* a [VPN Connection](https://www.terraform.io/docs/providers/aws/r/vpn_connection.html)
* a [VPN Gateway Attachment](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_attachment.html)
* one or more [VPN Gateway Route Propagation](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html) depending on how many routing tables exists in a VPC

This module does not create a [VPN Gateway](https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html) resource because it is meant to be used in combination with the `terraform-aws-modules/vpc/aws` module that will create that resource (when `enable_vpn_gateway = true`).

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

  vpn_gateway_id = "${module.vpc.vgw_id}"
  vpc_id         = "${module.vpc.vpc_id}"
  vpc_subnet_ids = ["${module.vpc.private_route_table_ids}"]
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

  vpn_gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
  vpc_id = "${aws_vpc.vpc.vpc_id}"
  vpc_subnet_ids = ["${aws_subnet.*.id}"]
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
