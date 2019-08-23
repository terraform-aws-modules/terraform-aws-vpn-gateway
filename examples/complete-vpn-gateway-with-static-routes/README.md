# Complete VPN Gateway Setup

Configuration in this directory creates set of VPN Gateway related resources which may be sufficient for staging or production environment (look into [minimal-vpn-gateway](../minimal-vpn-gateway) for more simplified setup).

There will be a VPN Connection created linking a (pre-existing) VPN Gateway in a VPC to a (pre-existing) Customer Gateway, without automatic route propagation to selected VPC subnets enabled.

In this example, given we are providing tunnel cidrs and pre-shared keys, terraform (v0.11.x) will show changes to the infrastructure when planning after the first apply (see #18 for the full details).
To workaround that plan and apply twice to properly bootstrap the infrastructure. Subsequent plans should not offer  more changes unless the code or the infra has changed.

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
| vpc\_private\_subnets |  | list | `<list>` | no |

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
