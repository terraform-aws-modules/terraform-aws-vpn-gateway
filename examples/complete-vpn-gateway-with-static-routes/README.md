# Complete VPN Gateway Setup

Configuration in this directory creates set of VPN Gateway related resources which may be sufficient for staging or production environment (look into [minimal-vpn-gateway](../minimal-vpn-gateway) for more simplified setup).

There will be a VPN Connection created linking a (pre-existing) VPN Gateway in a VPC to a (pre-existing) Customer Gateway, without automatic route propagation to selected VPC subnets enabled.

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
| vpc_private_subnets |  | string | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn_connection_id |  |
| vpn_connection_tunnel1_address |  |
| vpn_connection_tunnel1_cgw_inside_address |  |
| vpn_connection_tunnel1_vgw_inside_address |  |
| vpn_connection_tunnel2_address |  |
| vpn_connection_tunnel2_cgw_inside_address |  |
| vpn_connection_tunnel2_vgw_inside_address |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
