# AWS VPN Gateway Terraform module

Terraform module which creates [VPN gateway](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html) resources on AWS.

This module creates:
* a [VPN Connection](https://www.terraform.io/docs/providers/aws/r/vpn_connection.html) unless `create_vpn_connection = false`
* a [VPN Gateway Attachment](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_attachment.html)
* one or more [VPN Gateway Route Propagation](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html) depending on how many routing tables exists in a VPC
* one or more [VPN Connection Route](https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html) if `create_vpn_connection = true` and `vpn_connection_static_routes_only = true`, and depending on the number of destinations provided in variable `vpn_connection_static_routes_destinations` (which must be inline with `vpc_subnet_route_table_count`)

This module does not create a [VPN Gateway](https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html) resource because it is meant to be used in combination with the [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) that will create that resource (when `enable_vpn_gateway = true`).
This module also does not create a [Customer Gateway](https://www.terraform.io/docs/providers/aws/r/customer_gateway.html) resource.
This module will create static routes for the VPN Connection if configured to create a VPN Connection resource with static routes and destinations for the routes have been provided.
The static routes will then be automatically propagated to the VPC subnet routing tables (provided in `private_route_table_ids`) once a VPN tunnel status is `UP`.
When static routes are disabled, the appliance behind the Customer Gateway needs to support BGP routing protocol in order for routes to be automatically discovered, and subsequently propagated to the VPC subnet routing tables.
This module supports optional parameters for tunnel inside cidr and preshared keys. They can be supplied individually, too.

## Usage

##### With [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws)

```hcl
module "vpn_gateway" {
  source = "terraform-aws-modules/vpn-gateway/aws"

  vpc_id                  = "${module.vpc.vpc_id}"
  vpn_gateway_id          = "${module.vpc.vgw_id}"
  customer_gateway_id     = "${aws_customer_gateway.main.id}"
  private_route_table_ids = ["${module.vpc.private_route_table_ids}"]

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = "${var.custom_tunnel1_inside_cidr}"
  tunnel2_inside_cidr   = "${var.custom_tunnel2_inside_cidr}"
  tunnel1_preshared_key = "${var.custom_tunnel1_preshared_key}"
  tunnel2_preshared_key = "${var.custom_tunnel2_preshared_key}"
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

##### Without VPC module

```hcl
module "vpn_gateway" {
  source = "terraform-aws-modules/vpn-gateway/aws"

  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.main.id}"
  vpc_id              = "${aws_vpc.vpc.vpc_id}"
  vpc_subnet_ids      = ["${aws_subnet.*.id}"]

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = "${var.custom_tunnel1_inside_cidr}"
  tunnel2_inside_cidr   = "${var.custom_tunnel2_inside_cidr}"
  tunnel1_preshared_key = "${var.custom_tunnel1_preshared_key}"
  tunnel2_preshared_key = "${var.custom_tunnel2_preshared_key}"
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

## Examples

* [Complete example](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/examples/complete-vpn-gateway) shows how to create all VPN Gateway resources.
* [Complete example with static routes](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/examples/complete-vpn-gateway-with-static-routes) shows how to create all VPN Gateway together with static routes.
* [Minimal example](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/examples/minimal-vpn-gateway) shows how to create just VPN Gateway using this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create_vpn_connection | Set to false to prevent the creation of a VPN Connection. | string | `true` | no |
| customer_gateway_id | The id of the Customer Gateway. | string | - | yes |
| tags | Set of tags to be added to the VPN Connection resource (only if `create_vpn_connection = true`). | map | `<map>` | no |
| tunnel1_inside_cidr | The CIDR block of the inside IP addresses for the first VPN tunnel. | string | `` | no |
| tunnel1_preshared_key | The preshared key of the first VPN tunnel. | string | `` | no |
| tunnel2_inside_cidr | The CIDR block of the inside IP addresses for the second VPN tunnel. | string | `` | no |
| tunnel2_preshared_key | The preshared key of the second VPN tunnel. | string | `` | no |
| vpc_id | The id of the VPC where the VPN Gateway lives. | string | - | yes |
| vpc_subnet_route_table_count | The number of subnet route table ids being passed in via `vpc_subnet_route_table_ids`. | string | `0` | no |
| vpc_subnet_route_table_ids | The ids of the VPC subnets for which routes from the VPN Gateway will be propagated. | list | `<list>` | no |
| vpn_connection_static_routes_destinations | List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`. | list | `<list>` | no |
| vpn_connection_static_routes_only | Set to true for the created VPN connection to use static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP. | string | `false` | no |
| vpn_gateway_id | The id of the VPN Gateway. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpn_connection_id | A list with the VPN Connection ID if `create_vpn_connection = true`, or empty otherwise |
| vpn_connection_tunnel1_address | A list with the the public IP address of the first VPN tunnel if `create_vpn_connection = true`, or empty otherwise |
| vpn_connection_tunnel1_cgw_inside_address | A list with the the RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
| vpn_connection_tunnel1_vgw_inside_address | A list with the the RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
| vpn_connection_tunnel2_address | A list with the the public IP address of the second VPN tunnel if `create_vpn_connection = true`, or empty otherwise |
| vpn_connection_tunnel2_cgw_inside_address | A list with the the RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
| vpn_connection_tunnel2_vgw_inside_address | A list with the the RFC 6890 link-local address of the second VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Currently maintained by [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/graphs/contributors).
Module managed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
