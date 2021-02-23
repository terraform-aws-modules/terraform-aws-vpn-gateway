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

## Resources

| Name |
|------|
| [aws_customer_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc\_private\_subnets | List of private subnets | `list(string)` | <pre>[<br>  "10.10.11.0/24",<br>  "10.10.12.0/24",<br>  "10.10.13.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn\_connection\_id | VPN id |
| vpn\_connection\_tunnel1\_address | Tunnel1 address |
| vpn\_connection\_tunnel1\_cgw\_inside\_address | Tunnel1 CGW address |
| vpn\_connection\_tunnel1\_vgw\_inside\_address | Tunnel1 VGW address |
| vpn\_connection\_tunnel2\_address | Tunnel2 address |
| vpn\_connection\_tunnel2\_cgw\_inside\_address | Tunnel2 CGW address |
| vpn\_connection\_tunnel2\_vgw\_inside\_address | Tunnel2 VGW address |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
