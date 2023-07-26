variable "vpc_private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
}

variable "tunnel1_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel."
  type        = string
  default     = null
}

variable "tunnel2_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel."
  type        = string
  default     = null
}

variable "tunnel1_preshared_key" {
  description = "The preshared key of the first VPN tunnel."
  type        = string
  default     = null
  sensitive   = true
}

variable "tunnel2_preshared_key" {
  description = "The preshared key of the second VPN tunnel."
  type        = string
  default     = null
  sensitive   = true
}
