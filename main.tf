resource "aws_vpn_connection" "default" {
  count = "${var.create_vpn_connection ? 1 : 0}"

  vpn_gateway_id      = "${var.vpn_gateway_id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "ipsec.1"

  static_routes_only = "${var.vpn_connection_static_routes_only}"

  tags = "${merge(
    map(
      "Name", "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    ),
    var.tags
  )}"
}

### Tunnel Inside CIDR only
resource "aws_vpn_connection" "tunnel" {
  count = "${var.create_vpn_connection && length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0 && length(var.tunnel1_preshared_key) == 0 && length(var.tunnel2_preshared_key) == 0 ? 1 : 0}"

  vpn_gateway_id      = "${var.vpn_gateway_id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "ipsec.1"

  static_routes_only = "${var.vpn_connection_static_routes_only}"

  tunnel1_inside_cidr = "${var.tunnel1_inside_cidr}"
  tunnel2_inside_cidr = "${var.tunnel2_inside_cidr}"

  tags = "${merge(
    map(
      "Name", "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    ),
    var.tags
  )}"
}

### Preshared Key only
resource "aws_vpn_connection" "preshared" {
  count = "${var.create_vpn_connection && length(var.tunnel1_inside_cidr) == 0  && length(var.tunnel2_inside_cidr) == 0 && length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0 ? 1 : 0}"

  vpn_gateway_id      = "${var.vpn_gateway_id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "ipsec.1"

  static_routes_only = "${var.vpn_connection_static_routes_only}"

  tunnel1_preshared_key = "${var.tunnel1_preshared_key}"
  tunnel2_preshared_key = "${var.tunnel2_preshared_key}"

  tags = "${merge(
    map(
      "Name", "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    ),
    var.tags
  )}"
}

### Tunnel Inside CIDR and Preshared Key
resource "aws_vpn_connection" "tunnel_preshared" {
  count = "${var.create_vpn_connection && length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0 && length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0 ? 1 : 0}"

  vpn_gateway_id      = "${var.vpn_gateway_id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "ipsec.1"

  static_routes_only = "${var.vpn_connection_static_routes_only}"

  tunnel1_inside_cidr = "${var.tunnel1_inside_cidr}"
  tunnel2_inside_cidr = "${var.tunnel2_inside_cidr}"

  tunnel1_preshared_key = "${var.tunnel1_preshared_key}"
  tunnel2_preshared_key = "${var.tunnel2_preshared_key}"

  tags = "${merge(
    map(
      "Name", "VPN Connection between VPC ${var.vpc_id} and Customer Gateway ${var.customer_gateway_id}"
    ),
    var.tags
  )}"
}

resource "aws_vpn_gateway_attachment" "default" {
  vpc_id         = "${var.vpc_id}"
  vpn_gateway_id = "${var.vpn_gateway_id}"
}

resource "aws_vpn_gateway_route_propagation" "private_subnets_vpn_routing" {
  count = "${var.vpc_subnet_route_table_count}"

  vpn_gateway_id = "${var.vpn_gateway_id}"
  route_table_id = "${element(var.vpc_subnet_route_table_ids, count.index)}"
}

resource "aws_vpn_connection_route" "default" {
  count = "${var.create_vpn_connection ? (var.vpn_connection_static_routes_only ? length(var.vpn_connection_static_routes_destinations) : 0) : 0}"

  vpn_connection_id      = "${element(split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.id) : "")), 0)}"
  destination_cidr_block = "${element(var.vpn_connection_static_routes_destinations, count.index)}"
}
