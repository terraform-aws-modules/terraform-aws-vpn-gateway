terraform {
  required_version = ">= 0.12"
}

locals {
  preshared_key_provided     = length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0
  preshared_key_not_provided = false == local.preshared_key_provided
  internal_cidr_provided     = length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0
  internal_cidr_not_provided = false == local.internal_cidr_provided

  tunnel_details_not_specified = local.internal_cidr_not_provided && local.preshared_key_not_provided
  tunnel_details_specified     = local.internal_cidr_provided && local.preshared_key_provided

  create_tunner_with_internal_cidr_only = local.internal_cidr_provided && local.preshared_key_not_provided
  create_tunner_with_preshared_key_only = local.internal_cidr_not_provided && local.preshared_key_provided
}

### Fully AWS managed
resource "aws_vpn_connection" "default" {
  count = var.create_vpn_connection && local.tunnel_details_not_specified ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tags = merge(
    {
      "Name" = "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    },
    var.tags,
  )
}

### Tunnel Inside CIDR only
resource "aws_vpn_connection" "tunnel" {
  count = var.create_vpn_connection && local.create_tunner_with_internal_cidr_only ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_inside_cidr = var.tunnel1_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr

  tags = merge(
    {
      "Name" = "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    },
    var.tags,
  )
}

### Preshared Key only
resource "aws_vpn_connection" "preshared" {
  count = var.create_vpn_connection && local.create_tunner_with_preshared_key_only ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = merge(
    {
      "Name" = "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    },
    var.tags,
  )
}

### Tunnel Inside CIDR and Preshared Key
resource "aws_vpn_connection" "tunnel_preshared" {
  count = var.create_vpn_connection && local.tunnel_details_specified ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_inside_cidr = var.tunnel1_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr

  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = merge(
    {
      "Name" = "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    },
    var.tags,
  )
}

resource "aws_vpn_gateway_attachment" "default" {
  count = var.create_vpn_connection && var.create_vpn_gateway_attachment ? 1 : 0

  vpc_id         = var.vpc_id
  vpn_gateway_id = var.vpn_gateway_id
}

resource "aws_vpn_gateway_route_propagation" "private_subnets_vpn_routing" {
  count = var.create_vpn_connection ? var.vpc_subnet_route_table_count : 0

  vpn_gateway_id = var.vpn_gateway_id
  route_table_id = element(var.vpc_subnet_route_table_ids, count.index)
}

resource "aws_vpn_connection_route" "default" {
  count = var.create_vpn_connection ? var.vpn_connection_static_routes_only ? length(var.vpn_connection_static_routes_destinations) : 0 : 0

  vpn_connection_id = element(
    split(
      ",",
      local.create_tunner_with_internal_cidr_only ? join(",", aws_vpn_connection.tunnel.*.id) : local.create_tunner_with_preshared_key_only ? join(",", aws_vpn_connection.preshared.*.id) : local.tunnel_details_specified ? join(",", aws_vpn_connection.tunnel_preshared.*.id) : join(",", aws_vpn_connection.default.*.id),
    ),
    0,
  )
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}

