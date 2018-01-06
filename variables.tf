variable "vpn_gateway_id" {}

variable "create_vpn_connection" {
  default = true
}

variable "vpc_id" {}

variable "vpc_subnet_route_table_ids" {
  type    = "list"
  default = []
}
