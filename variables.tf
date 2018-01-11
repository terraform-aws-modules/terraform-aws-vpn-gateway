variable "vpn_gateway_id" {
  description = "The id of the VPN Gateway."
}

variable "customer_gateway_id" {
  description = "The id of the Customer Gateway."
}

variable "create_vpn_connection" {
  description = "Set to false to prevent the creation of a VPN Connection."
  default     = true
}

variable "vpc_id" {
  description = "The id of the VPC where the VPN Gateway lives."
}

variable "vpc_subnet_route_table_ids" {
  description = "The ids of the VPC subnets for which routes from the VPN Gateway will be propagated."
  type        = "list"
  default     = []
}

# Workaround for limitation when using computed values in count attribute
# https://github.com/hashicorp/terraform/issues/10857
variable "vpc_subnet_route_table_count" {
  description = "The number of subnet route table ids being passed in via `vpc_subnet_route_table_ids`."
  default     = 0
}

variable "tags" {
  description = "Set of tags to be added to the VPN Connection resource (only if `create_vpn_connection = true`)."
  type        = "map"
  default     = {}
}

variable "vpn_connection_static_routes_only" {
  description = "Set to true for the created VPN connection to use static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
  default     = false
}

variable "vpn_connection_static_routes_destinations" {
  description = "List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`."
  type        = "list"
  default     = []
}
