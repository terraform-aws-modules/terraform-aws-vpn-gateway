resource "aws_vpn_connection" "default" {
  count = "${var.create_vpn_connection ? 1 : 0}"

  vpn_gateway_id      = "${var.vpn_gateway_id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "ipsec.1"
}

resource "aws_vpn_gateway_attachment" "default" {
  vpc_id         = "${var.vpc_id}"
  vpn_gateway_id = "${var.vpn_gateway_id}"
}

resource "aws_vpn_gateway_route_propagation" "private_subnets_vpn_routing" {
  count = "${length(var.vpc_subnet_route_table_ids)}"

  vpn_gateway_id = "${var.vpn_gateway_id}"
  route_table_id = "${element(var.vpc_subnet_route_table_ids, count.index)}"
}
