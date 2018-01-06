output "vpn_connection_id" {
  description = "A list with the VPN Connection ID if `create_vpn_connection = true`, or empty otherwise"
  value       = "${split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.id) : ""))}"
}

output "vpn_connection_tunnel1_address" {
  description = "A list with the the public IP address of the first VPN tunnel if `create_vpn_connection = true`, or empty otherwise"
  value       = "${split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.tunnel1_address) : ""))}"
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value       = "${split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.tunnel1_cgw_inside_address ) : ""))}"
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value       = "${split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.tunnel1_vgw_inside_address ) : ""))}"
}

output "vpn_connection_tunnel2_address" {
  description = "A list with the the public IP address of the second VPN tunnel if `create_vpn_connection = true`, or empty otherwise"
  value       = "${split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.tunnel2_address) : ""))}"
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value       = "${split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.tunnel2_cgw_inside_address ) : ""))}"
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the second VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value       = "${split(",", (var.create_vpn_connection ? join(",", aws_vpn_connection.default.*.tunnel2_vgw_inside_address ) : ""))}"
}
