# Complete VPN Connection with Transit Gateway

Configuration in this directory creates two VPN Connections (one per Customer Gateway) linked to Transit Gateway which is connected to private subnets of VPC.

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
| vpc\_public\_subnets |  | list(string) | `[ "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24" ]` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn\_connection\_id |  |
| vpn\_connection\_transit\_gateway\_attachment\_id |  |
| vpn\_connection\_tunnel1\_address |  |
| vpn\_connection\_tunnel1\_cgw\_inside\_address |  |
| vpn\_connection\_tunnel1\_vgw\_inside\_address |  |
| vpn\_connection\_tunnel2\_address |  |
| vpn\_connection\_tunnel2\_cgw\_inside\_address |  |
| vpn\_connection\_tunnel2\_vgw\_inside\_address |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
