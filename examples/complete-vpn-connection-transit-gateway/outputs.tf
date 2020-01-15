output "vpn_connection_id" {
  value = module.vpn_gateway_1.vpn_connection_id
}

output "vpn_connection_tunnel1_address" {
  value = module.vpn_gateway_1.vpn_connection_tunnel1_address
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  value = module.vpn_gateway_1.vpn_connection_tunnel1_cgw_inside_address
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  value = module.vpn_gateway_1.vpn_connection_tunnel1_vgw_inside_address
}

output "vpn_connection_tunnel2_address" {
  value = module.vpn_gateway_1.vpn_connection_tunnel2_address
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  value = module.vpn_gateway_1.vpn_connection_tunnel2_cgw_inside_address
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  value = module.vpn_gateway_1.vpn_connection_tunnel2_vgw_inside_address
}

output "vpn_connection_transit_gateway_attachment_id" {
  value = module.vpn_gateway_1.vpn_connection_transit_gateway_attachment_id
}
