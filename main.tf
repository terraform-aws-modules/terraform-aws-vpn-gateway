locals {
  preshared_key_provided     = length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0
  preshared_key_not_provided = false == local.preshared_key_provided
  internal_cidr_provided     = length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0
  internal_cidr_not_provided = false == local.internal_cidr_provided

  tunnel_details_not_specified = local.internal_cidr_not_provided && local.preshared_key_not_provided
  tunnel_details_specified     = local.internal_cidr_provided && local.preshared_key_provided

  create_tunnel_with_internal_cidr_only = local.internal_cidr_provided && local.preshared_key_not_provided
  create_tunnel_with_preshared_key_only = local.internal_cidr_not_provided && local.preshared_key_provided

  connection_identifier = var.connect_to_transit_gateway ? "TGW ${var.transit_gateway_id}" : "VPC ${var.vpc_id}"
  name_tag              = "VPN Connection between ${local.connection_identifier} and Customer Gateway ${var.customer_gateway_id}"
}

### Fully AWS managed
resource "aws_vpn_connection" "default" {
  count = var.create_vpn_connection && local.tunnel_details_not_specified ? 1 : 0

  vpn_gateway_id     = var.vpn_gateway_id
  transit_gateway_id = var.transit_gateway_id

  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_phase1_dh_group_numbers = var.tunnel1_phase1_dh_group_numbers
  tunnel2_phase1_dh_group_numbers = var.tunnel2_phase1_dh_group_numbers

  tunnel1_phase1_encryption_algorithms = var.tunnel1_phase1_encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.tunnel2_phase1_encryption_algorithms

  tunnel1_phase1_integrity_algorithms = var.tunnel1_phase1_integrity_algorithms
  tunnel2_phase1_integrity_algorithms = var.tunnel2_phase1_integrity_algorithms

  tunnel1_phase1_lifetime_seconds = var.tunnel1_phase1_lifetime_seconds
  tunnel2_phase1_lifetime_seconds = var.tunnel2_phase1_lifetime_seconds

  tunnel1_dpd_timeout_seconds = var.tunnel1_dpd_timeout_seconds
  tunnel2_dpd_timeout_seconds = var.tunnel2_dpd_timeout_seconds

  tunnel1_dpd_timeout_action = var.tunnel1_dpd_timeout_action
  tunnel2_dpd_timeout_action = var.tunnel2_dpd_timeout_action

  tunnel1_phase2_dh_group_numbers = var.tunnel1_phase2_dh_group_numbers
  tunnel2_phase2_dh_group_numbers = var.tunnel2_phase2_dh_group_numbers

  tunnel1_phase2_encryption_algorithms = var.tunnel1_phase2_encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.tunnel2_phase2_encryption_algorithms

  tunnel1_phase2_integrity_algorithms = var.tunnel1_phase2_integrity_algorithms
  tunnel2_phase2_integrity_algorithms = var.tunnel2_phase2_integrity_algorithms

  tunnel1_phase2_lifetime_seconds = var.tunnel1_phase2_lifetime_seconds
  tunnel2_phase2_lifetime_seconds = var.tunnel2_phase2_lifetime_seconds

  tunnel1_rekey_fuzz_percentage = var.tunnel1_rekey_fuzz_percentage
  tunnel2_rekey_fuzz_percentage = var.tunnel2_rekey_fuzz_percentage

  tunnel1_rekey_margin_time_seconds = var.tunnel1_rekey_margin_time_seconds
  tunnel2_rekey_margin_time_seconds = var.tunnel2_rekey_margin_time_seconds

  tunnel1_replay_window_size = var.tunnel1_replay_window_size
  tunnel2_replay_window_size = var.tunnel2_replay_window_size

  tunnel1_startup_action = var.tunnel1_startup_action
  tunnel2_startup_action = var.tunnel2_startup_action

  tunnel1_ike_versions = var.tunnel1_ike_versions
  tunnel2_ike_versions = var.tunnel2_ike_versions

  local_ipv4_network_cidr  = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.remote_ipv4_network_cidr

  tags = merge(
    {
      "Name" = local.name_tag
    },
    var.tags,
  )
}

### Tunnel Inside CIDR only
resource "aws_vpn_connection" "tunnel" {
  count = var.create_vpn_connection && local.create_tunnel_with_internal_cidr_only ? 1 : 0

  vpn_gateway_id     = var.vpn_gateway_id
  transit_gateway_id = var.transit_gateway_id

  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_inside_cidr = var.tunnel1_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr

  tunnel1_phase1_dh_group_numbers = var.tunnel1_phase1_dh_group_numbers
  tunnel2_phase1_dh_group_numbers = var.tunnel2_phase1_dh_group_numbers

  tunnel1_phase1_encryption_algorithms = var.tunnel1_phase1_encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.tunnel2_phase1_encryption_algorithms

  tunnel1_phase1_integrity_algorithms = var.tunnel1_phase1_integrity_algorithms
  tunnel2_phase1_integrity_algorithms = var.tunnel2_phase1_integrity_algorithms

  tunnel1_phase1_lifetime_seconds = var.tunnel1_phase1_lifetime_seconds
  tunnel2_phase1_lifetime_seconds = var.tunnel2_phase1_lifetime_seconds

  tunnel1_dpd_timeout_seconds = var.tunnel1_dpd_timeout_seconds
  tunnel2_dpd_timeout_seconds = var.tunnel2_dpd_timeout_seconds

  tunnel1_dpd_timeout_action = var.tunnel1_dpd_timeout_action
  tunnel2_dpd_timeout_action = var.tunnel2_dpd_timeout_action

  tunnel1_phase2_dh_group_numbers = var.tunnel1_phase2_dh_group_numbers
  tunnel2_phase2_dh_group_numbers = var.tunnel2_phase2_dh_group_numbers

  tunnel1_phase2_encryption_algorithms = var.tunnel1_phase2_encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.tunnel2_phase2_encryption_algorithms

  tunnel1_phase2_integrity_algorithms = var.tunnel1_phase2_integrity_algorithms
  tunnel2_phase2_integrity_algorithms = var.tunnel2_phase2_integrity_algorithms

  tunnel1_phase2_lifetime_seconds = var.tunnel1_phase2_lifetime_seconds
  tunnel2_phase2_lifetime_seconds = var.tunnel2_phase2_lifetime_seconds

  tunnel1_rekey_fuzz_percentage = var.tunnel1_rekey_fuzz_percentage
  tunnel2_rekey_fuzz_percentage = var.tunnel2_rekey_fuzz_percentage

  tunnel1_rekey_margin_time_seconds = var.tunnel1_rekey_margin_time_seconds
  tunnel2_rekey_margin_time_seconds = var.tunnel2_rekey_margin_time_seconds

  tunnel1_replay_window_size = var.tunnel1_replay_window_size
  tunnel2_replay_window_size = var.tunnel2_replay_window_size

  tunnel1_startup_action = var.tunnel1_startup_action
  tunnel2_startup_action = var.tunnel2_startup_action

  tunnel1_ike_versions = var.tunnel1_ike_versions
  tunnel2_ike_versions = var.tunnel2_ike_versions

  local_ipv4_network_cidr  = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.remote_ipv4_network_cidr

  tags = merge(
    {
      "Name" = local.name_tag
    },
    var.tags,
  )
}

### Preshared Key only
resource "aws_vpn_connection" "preshared" {
  count = var.create_vpn_connection && local.create_tunnel_with_preshared_key_only ? 1 : 0

  vpn_gateway_id     = var.vpn_gateway_id
  transit_gateway_id = var.transit_gateway_id

  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tunnel1_phase1_dh_group_numbers = var.tunnel1_phase1_dh_group_numbers
  tunnel2_phase1_dh_group_numbers = var.tunnel2_phase1_dh_group_numbers

  tunnel1_phase1_encryption_algorithms = var.tunnel1_phase1_encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.tunnel2_phase1_encryption_algorithms

  tunnel1_phase1_integrity_algorithms = var.tunnel1_phase1_integrity_algorithms
  tunnel2_phase1_integrity_algorithms = var.tunnel2_phase1_integrity_algorithms

  tunnel1_phase1_lifetime_seconds = var.tunnel1_phase1_lifetime_seconds
  tunnel2_phase1_lifetime_seconds = var.tunnel2_phase1_lifetime_seconds

  tunnel1_dpd_timeout_action = var.tunnel1_dpd_timeout_action
  tunnel2_dpd_timeout_action = var.tunnel2_dpd_timeout_action

  tunnel1_phase2_dh_group_numbers = var.tunnel1_phase2_dh_group_numbers
  tunnel2_phase2_dh_group_numbers = var.tunnel2_phase2_dh_group_numbers

  tunnel1_phase2_encryption_algorithms = var.tunnel1_phase2_encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.tunnel2_phase2_encryption_algorithms

  tunnel1_phase2_integrity_algorithms = var.tunnel1_phase2_integrity_algorithms
  tunnel2_phase2_integrity_algorithms = var.tunnel2_phase2_integrity_algorithms

  tunnel1_phase2_lifetime_seconds = var.tunnel1_phase2_lifetime_seconds
  tunnel2_phase2_lifetime_seconds = var.tunnel2_phase2_lifetime_seconds

  tunnel1_rekey_fuzz_percentage = var.tunnel1_rekey_fuzz_percentage
  tunnel2_rekey_fuzz_percentage = var.tunnel2_rekey_fuzz_percentage

  tunnel1_rekey_margin_time_seconds = var.tunnel1_rekey_margin_time_seconds
  tunnel2_rekey_margin_time_seconds = var.tunnel2_rekey_margin_time_seconds

  tunnel1_replay_window_size = var.tunnel1_replay_window_size
  tunnel2_replay_window_size = var.tunnel2_replay_window_size

  tunnel1_startup_action = var.tunnel1_startup_action
  tunnel2_startup_action = var.tunnel2_startup_action

  tunnel1_ike_versions = var.tunnel1_ike_versions
  tunnel2_ike_versions = var.tunnel2_ike_versions

  local_ipv4_network_cidr  = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.remote_ipv4_network_cidr

  tags = merge(
    {
      "Name" = local.name_tag
    },
    var.tags,
  )
}

### Tunnel Inside CIDR and Preshared Key
resource "aws_vpn_connection" "tunnel_preshared" {
  count = var.create_vpn_connection && local.tunnel_details_specified ? 1 : 0

  vpn_gateway_id     = var.vpn_gateway_id
  transit_gateway_id = var.transit_gateway_id

  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_inside_cidr = var.tunnel1_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr

  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tunnel1_phase1_dh_group_numbers = var.tunnel1_phase1_dh_group_numbers
  tunnel2_phase1_dh_group_numbers = var.tunnel2_phase1_dh_group_numbers

  tunnel1_phase1_encryption_algorithms = var.tunnel1_phase1_encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.tunnel2_phase1_encryption_algorithms

  tunnel1_phase1_integrity_algorithms = var.tunnel1_phase1_integrity_algorithms
  tunnel2_phase1_integrity_algorithms = var.tunnel2_phase1_integrity_algorithms

  tunnel1_phase1_lifetime_seconds = var.tunnel1_phase1_lifetime_seconds
  tunnel2_phase1_lifetime_seconds = var.tunnel2_phase1_lifetime_seconds

  tunnel1_dpd_timeout_action = var.tunnel1_dpd_timeout_action
  tunnel2_dpd_timeout_action = var.tunnel2_dpd_timeout_action

  tunnel1_phase2_dh_group_numbers = var.tunnel1_phase2_dh_group_numbers
  tunnel2_phase2_dh_group_numbers = var.tunnel2_phase2_dh_group_numbers

  tunnel1_phase2_encryption_algorithms = var.tunnel1_phase2_encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.tunnel2_phase2_encryption_algorithms

  tunnel1_phase2_integrity_algorithms = var.tunnel1_phase2_integrity_algorithms
  tunnel2_phase2_integrity_algorithms = var.tunnel2_phase2_integrity_algorithms

  tunnel1_phase2_lifetime_seconds = var.tunnel1_phase2_lifetime_seconds
  tunnel2_phase2_lifetime_seconds = var.tunnel2_phase2_lifetime_seconds

  tunnel1_rekey_fuzz_percentage = var.tunnel1_rekey_fuzz_percentage
  tunnel2_rekey_fuzz_percentage = var.tunnel2_rekey_fuzz_percentage

  tunnel1_rekey_margin_time_seconds = var.tunnel1_rekey_margin_time_seconds
  tunnel2_rekey_margin_time_seconds = var.tunnel2_rekey_margin_time_seconds

  tunnel1_replay_window_size = var.tunnel1_replay_window_size
  tunnel2_replay_window_size = var.tunnel2_replay_window_size

  tunnel1_startup_action = var.tunnel1_startup_action
  tunnel2_startup_action = var.tunnel2_startup_action

  tunnel1_ike_versions = var.tunnel1_ike_versions
  tunnel2_ike_versions = var.tunnel2_ike_versions

  local_ipv4_network_cidr  = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.remote_ipv4_network_cidr

  tags = merge(
    {
      "Name" = local.name_tag
    },
    var.tags,
  )
}

resource "aws_vpn_gateway_attachment" "default" {
  count = var.create_vpn_connection && var.create_vpn_gateway_attachment && !var.connect_to_transit_gateway ? 1 : 0

  vpc_id         = var.vpc_id
  vpn_gateway_id = var.vpn_gateway_id
}

resource "aws_vpn_gateway_route_propagation" "private_subnets_vpn_routing" {
  count = var.create_vpn_connection && !var.connect_to_transit_gateway ? var.vpc_subnet_route_table_count : 0

  vpn_gateway_id = var.vpn_gateway_id
  route_table_id = element(var.vpc_subnet_route_table_ids, count.index)
}

resource "aws_vpn_connection_route" "default" {
  count = var.create_vpn_connection && var.vpn_connection_static_routes_only && !var.connect_to_transit_gateway ? length(var.vpn_connection_static_routes_destinations) : 0

  vpn_connection_id = local.create_tunnel_with_internal_cidr_only ? aws_vpn_connection.tunnel[0].id : local.create_tunnel_with_preshared_key_only ? aws_vpn_connection.preshared[0].id : local.tunnel_details_specified ? aws_vpn_connection.tunnel_preshared[0].id : aws_vpn_connection.default[0].id

  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}
