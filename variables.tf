variable "vpn_gateway_id" {}

variable "vpc_id" {}

variable "vpc_subnet_ids" {
  type    = "list"
  default = []
}
