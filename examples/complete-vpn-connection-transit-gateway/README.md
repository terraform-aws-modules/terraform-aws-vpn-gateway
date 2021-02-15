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
| vpc\_public\_subnets | n/a | `list(string)` | <pre>[<br>  "10.10.1.0/24",<br>  "10.10.2.0/24",<br>  "10.10.3.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn\_connection\_id | n/a |
| vpn\_connection\_transit\_gateway\_attachment\_id | n/a |
| vpn\_connection\_tunnel1\_address | n/a |
| vpn\_connection\_tunnel1\_cgw\_inside\_address | n/a |
| vpn\_connection\_tunnel1\_vgw\_inside\_address | n/a |
| vpn\_connection\_tunnel2\_address | n/a |
| vpn\_connection\_tunnel2\_cgw\_inside\_address | n/a |
| vpn\_connection\_tunnel2\_vgw\_inside\_address | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
