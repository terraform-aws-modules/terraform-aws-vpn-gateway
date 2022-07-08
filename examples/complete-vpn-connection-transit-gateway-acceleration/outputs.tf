output "vpn_connection_id" {
  description = "VPN id"
  value       = module.vpn_gateway_1.vpn_connection_id
}

output "vpn_connection_tunnel1_address" {
  description = "Tunnel1 address"
  value       = module.vpn_gateway_1.vpn_connection_tunnel1_address
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  description = "Tunnel1 CGW address"
  value       = module.vpn_gateway_1.vpn_connection_tunnel1_cgw_inside_address
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  description = "Tunnel1 VGW address"
  value       = module.vpn_gateway_1.vpn_connection_tunnel1_vgw_inside_address
}

output "vpn_connection_tunnel2_address" {
  description = "Tunnel2 address"
  value       = module.vpn_gateway_1.vpn_connection_tunnel2_address
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  description = "Tunnel2 CGW address"
  value       = module.vpn_gateway_1.vpn_connection_tunnel2_cgw_inside_address
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  description = "Tunnel2 VGW address"
  value       = module.vpn_gateway_1.vpn_connection_tunnel2_vgw_inside_address
}

output "vpn_connection_transit_gateway_attachment_id" {
  description = "VPN TGW attachment id"
  value       = module.vpn_gateway_1.vpn_connection_transit_gateway_attachment_id
}
