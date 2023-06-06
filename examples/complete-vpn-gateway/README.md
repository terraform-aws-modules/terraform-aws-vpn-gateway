# Complete VPN Gateway Setup

Configuration in this directory creates set of VPN Gateway related resources which may be sufficient for staging or production environment (look into [minimal-vpn-gateway](../minimal-vpn-gateway) for more simplified setup).

There will be a VPN Connection created linking a (pre-existing) VPN Gateway in a VPC to a (pre-existing) Customer Gateway, with automatic route propagation to selected VPC subnets enabled.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.66 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.66 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |
| <a name="module_vpn_gateway"></a> [vpn\_gateway](#module\_vpn\_gateway) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.tunnel1_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.tunnel2_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_customer_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_private_subnets"></a> [vpc\_private\_subnets](#input\_vpc\_private\_subnets) | List of private subnets | `list(string)` | <pre>[<br>  "10.10.11.0/24",<br>  "10.10.12.0/24",<br>  "10.10.13.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_connection_id"></a> [vpn\_connection\_id](#output\_vpn\_connection\_id) | VPN id |
| <a name="output_vpn_connection_tunnel1_address"></a> [vpn\_connection\_tunnel1\_address](#output\_vpn\_connection\_tunnel1\_address) | Tunnel1 address |
| <a name="output_vpn_connection_tunnel1_cgw_inside_address"></a> [vpn\_connection\_tunnel1\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_cgw\_inside\_address) | Tunnel1 CGW address |
| <a name="output_vpn_connection_tunnel1_preshared_key"></a> [vpn\_connection\_tunnel1\_preshared\_key](#output\_vpn\_connection\_tunnel1\_preshared\_key) | Tunnel1 preshared key |
| <a name="output_vpn_connection_tunnel1_vgw_inside_address"></a> [vpn\_connection\_tunnel1\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_vgw\_inside\_address) | Tunnel1 VGW address |
| <a name="output_vpn_connection_tunnel2_address"></a> [vpn\_connection\_tunnel2\_address](#output\_vpn\_connection\_tunnel2\_address) | Tunnel2 address |
| <a name="output_vpn_connection_tunnel2_cgw_inside_address"></a> [vpn\_connection\_tunnel2\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_cgw\_inside\_address) | Tunnel2 CGW address |
| <a name="output_vpn_connection_tunnel2_preshared_key"></a> [vpn\_connection\_tunnel2\_preshared\_key](#output\_vpn\_connection\_tunnel2\_preshared\_key) | Tunnel2 preshared key |
| <a name="output_vpn_connection_tunnel2_vgw_inside_address"></a> [vpn\_connection\_tunnel2\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_vgw\_inside\_address) | Tunnel2 VGW address |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
