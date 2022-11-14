output "vpn_connection_id" {
  description = "A list with the VPN Connection ID if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].id,
    aws_vpn_connection.tunnel[0].id,
    aws_vpn_connection.preshared[0].id,
    aws_vpn_connection.tunnel_preshared[0].id,
    "")
  )
}

output "vpn_connection_tunnel1_address" {
  description = "A list with the the public IP address of the first VPN tunnel if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].tunnel1_address,
    aws_vpn_connection.tunnel[0].tunnel1_address,
    aws_vpn_connection.preshared[0].tunnel1_address,
    aws_vpn_connection.tunnel_preshared[0].tunnel1_address,
    "")
  )
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].tunnel1_cgw_inside_address,
    aws_vpn_connection.tunnel[0].tunnel1_cgw_inside_address,
    aws_vpn_connection.preshared[0].tunnel1_cgw_inside_address,
    aws_vpn_connection.tunnel_preshared[0].tunnel1_cgw_inside_address,
    "")
  )
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].tunnel1_vgw_inside_address,
    aws_vpn_connection.tunnel[0].tunnel1_vgw_inside_address,
    aws_vpn_connection.preshared[0].tunnel1_vgw_inside_address,
    aws_vpn_connection.tunnel_preshared[0].tunnel1_vgw_inside_address,
    "")
  )
}

output "vpn_connection_tunnel2_address" {
  description = "A list with the the public IP address of the second VPN tunnel if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].tunnel2_address,
    aws_vpn_connection.tunnel[0].tunnel2_address,
    aws_vpn_connection.preshared[0].tunnel2_address,
    aws_vpn_connection.tunnel_preshared[0].tunnel2_address,
    "")
  )
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].tunnel2_cgw_inside_address,
    aws_vpn_connection.tunnel[0].tunnel2_cgw_inside_address,
    aws_vpn_connection.preshared[0].tunnel2_cgw_inside_address,
    aws_vpn_connection.tunnel_preshared[0].tunnel2_cgw_inside_address,
    "")
  )
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  description = "A list with the the RFC 6890 link-local address of the second VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].tunnel2_vgw_inside_address,
    aws_vpn_connection.tunnel[0].tunnel2_vgw_inside_address,
    aws_vpn_connection.preshared[0].tunnel2_vgw_inside_address,
    aws_vpn_connection.tunnel_preshared[0].tunnel2_vgw_inside_address,
    "")
  )
}

output "vpn_connection_transit_gateway_attachment_id" {
  description = "The transit gateway attachment ID that was generated when attaching this VPN connection."
  value = try(coalesce(
    aws_vpn_connection.default[0].transit_gateway_attachment_id,
    aws_vpn_connection.tunnel[0].transit_gateway_attachment_id,
    aws_vpn_connection.preshared[0].transit_gateway_attachment_id,
    aws_vpn_connection.tunnel_preshared[0].transit_gateway_attachment_id,
    "")
  )
}

output "vpn_connection_customer_gateway_configuration" {
  description = "The configuration information for the VPN connection's customer gateway (in the native XML format) if `create_vpn_connection = true`, or empty otherwise"
  value = try(coalesce(
    aws_vpn_connection.default[0].customer_gateway_configuration,
    aws_vpn_connection.tunnel[0].customer_gateway_configuration,
    aws_vpn_connection.preshared[0].customer_gateway_configuration,
    aws_vpn_connection.tunnel_preshared[0].customer_gateway_configuration,
    "")
  )
}

output "tunnel1_preshared_key" {
  description = "The preshared key of the first VPN tunnel."
  value       = var.tunnel1_preshared_key
}

output "tunnel2_preshared_key" {
  description = "The preshared key of the second VPN tunnel."
  value       = var.tunnel2_preshared_key
}
