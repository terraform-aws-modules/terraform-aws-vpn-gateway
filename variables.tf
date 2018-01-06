variable "vpn_gateway_id" {}

variable "customer_gateway_id" {}

variable "create_vpn_connection" {
  default = true
}

variable "vpc_id" {}

variable "vpc_subnet_route_table_ids" {
  type    = "list"
  default = []
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "vpn_connection_static_routes_only" {
  description = "Set to true for the created VPN connection to static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
  default     = false
}
