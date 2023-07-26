locals {
  connection_identifier = var.connect_to_transit_gateway ? "TGW ${var.transit_gateway_id}" : "VPC ${var.vpc_id}"
  name_tag              = "VPN Connection between ${local.connection_identifier} and Customer Gateway ${var.customer_gateway_id}"
}

### Fully AWS managed
resource "aws_vpn_connection" "this" {
  count = var.create_vpn_connection ? 1 : 0

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

  tunnel1_dpd_timeout_seconds = var.tunnel1_dpd_timeout_seconds
  tunnel2_dpd_timeout_seconds = var.tunnel2_dpd_timeout_seconds

  tunnel1_dpd_timeout_action = var.tunnel1_dpd_timeout_action
  tunnel2_dpd_timeout_action = var.tunnel2_dpd_timeout_action

  tunnel1_enable_tunnel_lifecycle_control = var.tunnel1_enable_tunnel_lifecycle_control
  tunnel2_enable_tunnel_lifecycle_control = var.tunnel2_enable_tunnel_lifecycle_control

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

  dynamic "tunnel1_log_options" {
    for_each = [var.tunnel1_log_options]

    content {
      dynamic "cloudwatch_log_options" {
        for_each = tunnel1_log_options.value

        content {
          log_enabled       = lookup(cloudwatch_log_options.value, "log_enabled", null)
          log_group_arn     = lookup(cloudwatch_log_options.value, "log_group_arn", null)
          log_output_format = lookup(cloudwatch_log_options.value, "log_output_format", null)
        }
      }
    }
  }

  dynamic "tunnel2_log_options" {
    for_each = [var.tunnel2_log_options]

    content {
      dynamic "cloudwatch_log_options" {
        for_each = tunnel2_log_options.value

        content {
          log_enabled       = lookup(cloudwatch_log_options.value, "log_enabled", null)
          log_group_arn     = lookup(cloudwatch_log_options.value, "log_group_arn", null)
          log_output_format = lookup(cloudwatch_log_options.value, "log_output_format", null)
        }
      }
    }
  }

  tunnel_inside_ip_version = var.tunnel_inside_ip_version

  local_ipv4_network_cidr  = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.remote_ipv4_network_cidr

  local_ipv6_network_cidr  = var.local_ipv6_network_cidr
  remote_ipv6_network_cidr = var.remote_ipv6_network_cidr

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

  vpn_connection_id = aws_vpn_connection.this[0].id
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}
