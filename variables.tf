variable "vpn_gateway_id" {
  description = "The id of the VPN Gateway"
}

variable "customer_gateway_id" {
  description = "The id of the Customer Gateway"
}

variable "create_vpn_connection" {
  description = "Set to false to prevent the creation of a VPN Connection"
  default     = true
}

variable "vpc_id" {
  description = "The id of the VPC where the VPN Gateway lives"
}

variable "vpc_subnet_route_table_ids" {
  description = "The ids of the VPC subnets for which routes from the VPN Gateway will be propagated"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "Set of tags to be added to the VPN Connection resource (only if `create_vpn_connection = true`)"
  type        = "map"
  default     = {}
}

variable "vpn_connection_static_routes_only" {
  description = "Set to true for the created VPN connection to static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
  default     = false
}
