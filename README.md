# terraform-aws-vpn-gateway
Terraform module which creates VPN gateway resources on AWS

Usage
-----

```hcl
provider "aws" {
  version = "~> 1.0.0"
  region  = "eu-west-1"
}

module "vpn_gateway" {
  source = "terraform-aws-modules/vpn-gateway/aws"

  vpn_gateway_id = "vgw-aaaaa"
  vpc_id = "vpc-bbbbb"
  vpc_subnet_ids = ["subnet-ccccc", "subnet-ddddd"]
}
```
