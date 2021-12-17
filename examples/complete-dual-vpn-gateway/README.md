# Complete VPN Gateway Setup

Configuration in this directory creates set of VPN Gateway related resources which may be sufficient for staging or production environment (look into [minimal-vpn-gateway](../minimal-vpn-gateway) for more simplified setup).

This example creates VPN Connetions to two separate VPN Endpoints. This is high redundant VPN setup for production environment. 
vGW and route propagation is configured in the terraform-aws-vpc module. In order to have this possibility additional variable needs to be set 

```
create_vpn_gateway_attachment = false 
```

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.43 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.43 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 2.0 |
| <a name="module_vpn_gateway"></a> [vpn\_gateway](#module\_vpn\_gateway) | ../../ | n/a |
| <a name="module_vpn_gateway2"></a> [vpn\_gateway2](#module\_vpn\_gateway2) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_customer_gateway.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_gateway2_vpn_connection_id"></a> [vpn\_gateway2\_vpn\_connection\_id](#output\_vpn\_gateway2\_vpn\_connection\_id) | VPN id |
| <a name="output_vpn_gateway2_vpn_connection_tunnel1_address"></a> [vpn\_gateway2\_vpn\_connection\_tunnel1\_address](#output\_vpn\_gateway2\_vpn\_connection\_tunnel1\_address) | Tunnel1 address |
| <a name="output_vpn_gateway2_vpn_connection_tunnel1_cgw_inside_address"></a> [vpn\_gateway2\_vpn\_connection\_tunnel1\_cgw\_inside\_address](#output\_vpn\_gateway2\_vpn\_connection\_tunnel1\_cgw\_inside\_address) | Tunnel1 CGW address |
| <a name="output_vpn_gateway2_vpn_connection_tunnel1_vgw_inside_address"></a> [vpn\_gateway2\_vpn\_connection\_tunnel1\_vgw\_inside\_address](#output\_vpn\_gateway2\_vpn\_connection\_tunnel1\_vgw\_inside\_address) | Tunnel1 VGW address |
| <a name="output_vpn_gateway2_vpn_connection_tunnel2_address"></a> [vpn\_gateway2\_vpn\_connection\_tunnel2\_address](#output\_vpn\_gateway2\_vpn\_connection\_tunnel2\_address) | Tunnel2 address |
| <a name="output_vpn_gateway2_vpn_connection_tunnel2_cgw_inside_address"></a> [vpn\_gateway2\_vpn\_connection\_tunnel2\_cgw\_inside\_address](#output\_vpn\_gateway2\_vpn\_connection\_tunnel2\_cgw\_inside\_address) | Tunnel2 CGW address |
| <a name="output_vpn_gateway2_vpn_connection_tunnel2_vgw_inside_address"></a> [vpn\_gateway2\_vpn\_connection\_tunnel2\_vgw\_inside\_address](#output\_vpn\_gateway2\_vpn\_connection\_tunnel2\_vgw\_inside\_address) | Tunnel2 VGW address |
| <a name="output_vpn_gateway_vpn_connection_id"></a> [vpn\_gateway\_vpn\_connection\_id](#output\_vpn\_gateway\_vpn\_connection\_id) | VPN id |
| <a name="output_vpn_gateway_vpn_connection_tunnel1_address"></a> [vpn\_gateway\_vpn\_connection\_tunnel1\_address](#output\_vpn\_gateway\_vpn\_connection\_tunnel1\_address) | Tunnel1 address |
| <a name="output_vpn_gateway_vpn_connection_tunnel1_cgw_inside_address"></a> [vpn\_gateway\_vpn\_connection\_tunnel1\_cgw\_inside\_address](#output\_vpn\_gateway\_vpn\_connection\_tunnel1\_cgw\_inside\_address) | Tunnel1 CGW address |
| <a name="output_vpn_gateway_vpn_connection_tunnel1_vgw_inside_address"></a> [vpn\_gateway\_vpn\_connection\_tunnel1\_vgw\_inside\_address](#output\_vpn\_gateway\_vpn\_connection\_tunnel1\_vgw\_inside\_address) | Tunnel1 VGW address |
| <a name="output_vpn_gateway_vpn_connection_tunnel2_address"></a> [vpn\_gateway\_vpn\_connection\_tunnel2\_address](#output\_vpn\_gateway\_vpn\_connection\_tunnel2\_address) | Tunnel2 address |
| <a name="output_vpn_gateway_vpn_connection_tunnel2_cgw_inside_address"></a> [vpn\_gateway\_vpn\_connection\_tunnel2\_cgw\_inside\_address](#output\_vpn\_gateway\_vpn\_connection\_tunnel2\_cgw\_inside\_address) | Tunnel2 CGW address |
| <a name="output_vpn_gateway_vpn_connection_tunnel2_vgw_inside_address"></a> [vpn\_gateway\_vpn\_connection\_tunnel2\_vgw\_inside\_address](#output\_vpn\_gateway\_vpn\_connection\_tunnel2\_vgw\_inside\_address) | Tunnel2 VGW address |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
