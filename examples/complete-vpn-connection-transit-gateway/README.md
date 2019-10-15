# Complete VPN Gateway Setup with Transit Gateway

Configuration in this directory creates set of VPN Gateway related resources which may be sufficient for staging or production environment (look into [minimal-vpn-gateway](../minimal-vpn-gateway) for more simplified setup).

There will be a VPN Connection created which is linked to a transit gateway. This transit gateway is linked to a sample VPC which will be created for you.

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
| vpn\_connection\_tunnel1\_address |  |
| vpn\_connection\_tunnel1\_cgw\_inside\_address |  |
| vpn\_connection\_tunnel1\_vgw\_inside\_address |  |
| vpn\_connection\_tunnel2\_address |  |
| vpn\_connection\_tunnel2\_cgw\_inside\_address |  |
| vpn\_connection\_tunnel2\_vgw\_inside\_address |  |
| transit\_gateway\_attachment\_id | |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
