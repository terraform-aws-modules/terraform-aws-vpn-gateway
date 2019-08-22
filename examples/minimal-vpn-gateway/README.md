# Minimal VPN Gateway setup

Configuration in this directory creates set of VPN Gateway related resources, excluding a VPN Connection, which may be sufficient for staging or production environment (look into [complete-vpn-gateway](../complete-vpn-gateway) for more complete setup).

There will not be a VPN Connection created linking a (pre-existing) VPN Gateway in a VPC to a (pre-existing) Customer Gateway.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc\_private\_subnets |  | list(string) | `[ "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24" ]` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn\_connection\_id |  |
| vpn\_connection\_tunnel1\_address |  |
| vpn\_connection\_tunnel1\_cgw\_inside\_address |  |
| vpn\_connection\_tunnel1\_vgw\_inside\_address |  |
| vpn\_connection\_tunnel2\_address |  |
| vpn\_connection\_tunnel2\_cgw\_inside\_address |  |
| vpn\_connection\_tunnel2\_vgw\_inside\_address |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->