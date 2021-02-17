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
| terraform | >= 0.12.21 |
| aws | >= 3.22 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.22 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| vpc | terraform-aws-modules/vpc/aws | ~> 2.0 |
| vpn_gateway | ../../ |  |
| vpn_gateway2 | ../../ |  |

## Resources

| Name |
|------|
| [aws_customer_gateway](https://registry.terraform.io/providers/hashicorp/aws/3.22/docs/resources/customer_gateway) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| vpn\_gateway2\_vpn\_connection\_id | n/a |
| vpn\_gateway2\_vpn\_connection\_tunnel1\_address | n/a |
| vpn\_gateway2\_vpn\_connection\_tunnel1\_cgw\_inside\_address | n/a |
| vpn\_gateway2\_vpn\_connection\_tunnel1\_vgw\_inside\_address | n/a |
| vpn\_gateway2\_vpn\_connection\_tunnel2\_address | n/a |
| vpn\_gateway2\_vpn\_connection\_tunnel2\_cgw\_inside\_address | n/a |
| vpn\_gateway2\_vpn\_connection\_tunnel2\_vgw\_inside\_address | n/a |
| vpn\_gateway\_vpn\_connection\_id | n/a |
| vpn\_gateway\_vpn\_connection\_tunnel1\_address | n/a |
| vpn\_gateway\_vpn\_connection\_tunnel1\_cgw\_inside\_address | n/a |
| vpn\_gateway\_vpn\_connection\_tunnel1\_vgw\_inside\_address | n/a |
| vpn\_gateway\_vpn\_connection\_tunnel2\_address | n/a |
| vpn\_gateway\_vpn\_connection\_tunnel2\_cgw\_inside\_address | n/a |
| vpn\_gateway\_vpn\_connection\_tunnel2\_vgw\_inside\_address | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
