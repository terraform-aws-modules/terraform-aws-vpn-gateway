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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc\_private\_subnets | n/a | `list(string)` | <pre>[<br>  "10.10.11.0/24",<br>  "10.10.12.0/24",<br>  "10.10.13.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn\_connection\_id | n/a |
| vpn\_connection\_tunnel1\_address | n/a |
| vpn\_connection\_tunnel1\_cgw\_inside\_address | n/a |
| vpn\_connection\_tunnel1\_vgw\_inside\_address | n/a |
| vpn\_connection\_tunnel2\_address | n/a |
| vpn\_connection\_tunnel2\_cgw\_inside\_address | n/a |
| vpn\_connection\_tunnel2\_vgw\_inside\_address | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
