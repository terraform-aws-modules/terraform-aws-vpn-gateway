# AWS VPN Gateway Terraform module

Terraform module which creates [VPN gateway](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html) resources on AWS.

## Features

This module creates:

- a [VPN Connection](https://www.terraform.io/docs/providers/aws/r/vpn_connection.html) unless `create_vpn_connection = false`
- a [VPN Gateway Attachment](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_attachment.html)
- one or more [VPN Gateway Route Propagation](https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html) depending on how many routing tables exists in a VPC
- one or more [VPN Connection Route](https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html) if `create_vpn_connection = true` and `vpn_connection_static_routes_only = true`, and depending on the number of destinations provided in variable `vpn_connection_static_routes_destinations` (which must be inline with `vpc_subnet_route_table_count`)

This module does not create a [VPN Gateway](https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html) resource because it is meant to be used in combination with the [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) that will create that resource (when `enable_vpn_gateway = true`).
This module also does not create a [Customer Gateway](https://www.terraform.io/docs/providers/aws/r/customer_gateway.html) resource.
This module will create static routes for the VPN Connection if configured to create a VPN Connection resource with static routes and destinations for the routes have been provided.
The static routes will then be automatically propagated to the VPC subnet routing tables (provided in `private_route_table_ids`) once a VPN tunnel status is `UP`.
When static routes are disabled, the appliance behind the Customer Gateway needs to support BGP routing protocol in order for routes to be automatically discovered, and subsequently propagated to the VPC subnet routing tables.
This module supports optional parameters for tunnel inside cidr and preshared keys. They can be supplied individually, too.

If you want to use the Transit Gateway support you are responsible for creating the transit gateway resources (eg, using [terraform-aws-transit-gateway module](https://github.com/terraform-aws-modules/terraform-aws-transit-gateway)).

## Usage

### With [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws)

```hcl
module "vpn_gateway" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "~> 2.0"

  vpc_id                  = module.vpc.vpc_id
  vpn_gateway_id          = module.vpc.vgw_id
  customer_gateway_id     = module.vpc.cgw_ids[0]

  # precalculated length of module variable vpc_subnet_route_table_ids
  vpc_subnet_route_table_count = 3
  vpc_subnet_route_table_ids   = module.vpc.private_route_table_ids

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = var.custom_tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.custom_tunnel2_inside_cidr
  tunnel1_preshared_key = var.custom_tunnel1_preshared_key
  tunnel2_preshared_key = var.custom_tunnel2_preshared_key
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  enable_vpn_gateway = true
  amazon_side_asn    = 64620

  customer_gateways = {
    IP1 = {
      bgp_asn    = 65220
      ip_address = "172.83.124.10"
    },
    IP2 = {
      bgp_asn    = 65220
      ip_address = "172.83.124.11"
    }
  }

  # ...
}
```

### Without VPC module

```hcl
module "vpn_gateway" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "~> 2.0"

  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.main.id
  vpc_id              = aws_vpc.vpc.vpc_id

  vpc_subnet_route_table_count = 3
  vpc_subnet_route_table_ids   = ["rt-12322456", "rt-43433343", "rt-11223344"]

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = var.custom_tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.custom_tunnel2_inside_cidr
  tunnel1_preshared_key = var.custom_tunnel1_preshared_key
  tunnel2_preshared_key = var.custom_tunnel2_preshared_key
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "172.83.124.10"
  type       = "ipsec.1"

  tags {
    Name = "main-customer-gateway"
  }
}

resource "aws_vpc" "vpc" {
  # ...
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = aws_vpc.vpc.vpc_id

  # ...
}
```

### With VPC module and Transit Gateway resources

```hcl
module "vpn_gateway" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "~> 2.0"

  connect_to_transit_gateway = true
  transit_gateway_id         = aws_ec2_transit_gateway.this.id
  customer_gateway_id        = module.vpc.cgw_ids[0]

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = var.custom_tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.custom_tunnel2_inside_cidr
  tunnel1_preshared_key = var.custom_tunnel1_preshared_key
  tunnel2_preshared_key = var.custom_tunnel2_preshared_key
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  enable_vpn_gateway = true
  amazon_side_asn    = 64620

  customer_gateways = {
    IP1 = {
      bgp_asn    = 65220
      ip_address = "172.83.124.10"
    },
    IP2 = {
      bgp_asn    = 65220
      ip_address = "172.83.124.11"
    }
  }

  # ...
}

resource "aws_ec2_transit_gateway" "this" {
  description = "My TGW"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
  transit_gateway_id = aws_ec2_transit_gateway.this.id
}
```

### With VPC and Transit Gateway modules

```hcl
module "vpn_gateway" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "~> 2.0"

  connect_to_transit_gateway = true
  transit_gateway_id         = module.tgw.ec2_transit_gateway_id
  customer_gateway_id        = module.vpc.cgw_ids[0]

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = var.custom_tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.custom_tunnel2_inside_cidr
  tunnel1_preshared_key = var.custom_tunnel1_preshared_key
  tunnel2_preshared_key = var.custom_tunnel2_preshared_key
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  enable_vpn_gateway = true
  amazon_side_asn    = 64620

  customer_gateways = {
    IP1 = {
      bgp_asn    = 65220
      ip_address = "172.83.124.10"
    },
    IP2 = {
      bgp_asn    = 65220
      ip_address = "172.83.124.11"
    }
  }

  # ...
}

module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  name            = "my-tgw"
  description     = "My TGW shared with several other AWS accounts"
  amazon_side_asn = 64532

  vpc_attachments = {
    vpc1 = {
      vpc_id      = "vpc-12345678" # module.vpc.vpc_id <- will not work since computed values can't be used in `count`
      subnet_ids  = ["subnet-123456", "subnet-111222233"] # module.vpc.public_subnets <- will not work since computed values can't be used in `count`
      dns_support = true

      tgw_routes = [
        {
          destination_cidr_block = "30.0.0.0/16"
        },
        {
          blackhole              = true
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    }
  }
}
```

## Examples

- [Complete example](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/examples/complete-vpn-gateway) shows how to create all VPN Gateway resources and integration with VPC module.
- [Complete example with Transit Gateway](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/examples/complete-vpn-connection-transit-gateway) shows how to create VPN Connection between Transit Gateway and Customer Gateway.
- [Complete example with static routes](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/examples/complete-vpn-gateway-with-static-routes) shows how to create all VPN Gateway together with static routes.
- [Minimal example](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/examples/minimal-vpn-gateway) shows how to create just VPN Gateway using this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.43 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.43 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpn_connection.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection.preshared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection.tunnel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection.tunnel_preshared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection_route.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection_route) | resource |
| [aws_vpn_gateway_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway_attachment) | resource |
| [aws_vpn_gateway_route_propagation.private_subnets_vpn_routing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway_route_propagation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connect_to_transit_gateway"></a> [connect\_to\_transit\_gateway](#input\_connect\_to\_transit\_gateway) | Set to false to disable attachment of the VPN connection route to the VPN connection (TGW uses another resource for that) | `bool` | `false` | no |
| <a name="input_create_vpn_connection"></a> [create\_vpn\_connection](#input\_create\_vpn\_connection) | Set to false to prevent the creation of a VPN Connection. | `bool` | `true` | no |
| <a name="input_create_vpn_gateway_attachment"></a> [create\_vpn\_gateway\_attachment](#input\_create\_vpn\_gateway\_attachment) | Set to false to prevent attachment of the VGW to the VPC | `bool` | `true` | no |
| <a name="input_customer_gateway_id"></a> [customer\_gateway\_id](#input\_customer\_gateway\_id) | The id of the Customer Gateway. | `string` | n/a | yes |
| <a name="input_local_ipv4_network_cidr"></a> [local\_ipv4\_network\_cidr](#input\_local\_ipv4\_network\_cidr) | (Optional) The IPv4 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_remote_ipv4_network_cidr"></a> [remote\_ipv4\_network\_cidr](#input\_remote\_ipv4\_network\_cidr) | (Optional) The IPv4 CIDR on the AWS side of the VPN connection. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Set of tags to be added to the VPN Connection resource (only if `create_vpn_connection = true`). | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | The ID of the Transit Gateway. | `string` | `null` | no |
| <a name="input_tunnel1_dpd_timeout_action"></a> [tunnel1\_dpd\_timeout\_action](#input\_tunnel1\_dpd\_timeout\_action) | (Optional, Default clear) The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart | `string` | `null` | no |
| <a name="input_tunnel1_dpd_timeout_seconds"></a> [tunnel1\_dpd\_timeout\_seconds](#input\_tunnel1\_dpd\_timeout\_seconds) | (Optional, Default 30) The number of seconds after which a DPD timeout occurs for the first VPN tunnel. Valid value is equal or higher than 30 | `number` | `null` | no |
| <a name="input_tunnel1_ike_versions"></a> [tunnel1\_ike\_versions](#input\_tunnel1\_ike\_versions) | (Optional) The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 \| ikev2 | `list(string)` | `null` | no |
| <a name="input_tunnel1_inside_cidr"></a> [tunnel1\_inside\_cidr](#input\_tunnel1\_inside\_cidr) | The CIDR block of the inside IP addresses for the first VPN tunnel. | `string` | `""` | no |
| <a name="input_tunnel1_phase1_dh_group_numbers"></a> [tunnel1\_phase1\_dh\_group\_numbers](#input\_tunnel1\_phase1\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 | `list(number)` | `null` | no |
| <a name="input_tunnel1_phase1_encryption_algorithms"></a> [tunnel1\_phase1\_encryption\_algorithms](#input\_tunnel1\_phase1\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 | `list(string)` | `null` | no |
| <a name="input_tunnel1_phase1_integrity_algorithms"></a> [tunnel1\_phase1\_integrity\_algorithms](#input\_tunnel1\_phase1\_integrity\_algorithms) | (Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 | `list(string)` | `null` | no |
| <a name="input_tunnel1_phase1_lifetime_seconds"></a> [tunnel1\_phase1\_lifetime\_seconds](#input\_tunnel1\_phase1\_lifetime\_seconds) | (Optional, Default 28800) The lifetime for phase 1 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 28800 | `number` | `null` | no |
| <a name="input_tunnel1_phase2_dh_group_numbers"></a> [tunnel1\_phase2\_dh\_group\_numbers](#input\_tunnel1\_phase2\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 | `list(number)` | `null` | no |
| <a name="input_tunnel1_phase2_encryption_algorithms"></a> [tunnel1\_phase2\_encryption\_algorithms](#input\_tunnel1\_phase2\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 | `list(string)` | `null` | no |
| <a name="input_tunnel1_phase2_integrity_algorithms"></a> [tunnel1\_phase2\_integrity\_algorithms](#input\_tunnel1\_phase2\_integrity\_algorithms) | (Optional) List of one or more integrity algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 | `list(string)` | `null` | no |
| <a name="input_tunnel1_phase2_lifetime_seconds"></a> [tunnel1\_phase2\_lifetime\_seconds](#input\_tunnel1\_phase2\_lifetime\_seconds) | (Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 3600 | `number` | `null` | no |
| <a name="input_tunnel1_preshared_key"></a> [tunnel1\_preshared\_key](#input\_tunnel1\_preshared\_key) | The preshared key of the first VPN tunnel. | `string` | `""` | no |
| <a name="input_tunnel1_rekey_fuzz_percentage"></a> [tunnel1\_rekey\_fuzz\_percentage](#input\_tunnel1\_rekey\_fuzz\_percentage) | (Optional, Default 100) The percentage of the rekey window for the first VPN tunnel (determined by tunnel1\_rekey\_margin\_time\_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100 | `number` | `null` | no |
| <a name="input_tunnel1_rekey_margin_time_seconds"></a> [tunnel1\_rekey\_margin\_time\_seconds](#input\_tunnel1\_rekey\_margin\_time\_seconds) | (Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the first VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel1\_rekey\_fuzz\_percentage. Valid value is between 60 and half of tunnel1\_phase2\_lifetime\_seconds | `number` | `null` | no |
| <a name="input_tunnel1_replay_window_size"></a> [tunnel1\_replay\_window\_size](#input\_tunnel1\_replay\_window\_size) | (Optional, Default 1024) The number of packets in an IKE replay window for the first VPN tunnel. Valid value is between 64 and 2048. | `number` | `null` | no |
| <a name="input_tunnel1_startup_action"></a> [tunnel1\_startup\_action](#input\_tunnel1\_startup\_action) | (Optional, Default add) The action to take when the establishing the tunnel for the first VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start | `string` | `null` | no |
| <a name="input_tunnel2_dpd_timeout_action"></a> [tunnel2\_dpd\_timeout\_action](#input\_tunnel2\_dpd\_timeout\_action) | (Optional, Default clear) The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart | `string` | `null` | no |
| <a name="input_tunnel2_dpd_timeout_seconds"></a> [tunnel2\_dpd\_timeout\_seconds](#input\_tunnel2\_dpd\_timeout\_seconds) | (Optional, Default 30) The number of seconds after which a DPD timeout occurs for the second VPN tunnel. Valid value is equal or higher than 30 | `number` | `null` | no |
| <a name="input_tunnel2_ike_versions"></a> [tunnel2\_ike\_versions](#input\_tunnel2\_ike\_versions) | (Optional) The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 \| ikev2 | `list(string)` | `null` | no |
| <a name="input_tunnel2_inside_cidr"></a> [tunnel2\_inside\_cidr](#input\_tunnel2\_inside\_cidr) | The CIDR block of the inside IP addresses for the second VPN tunnel. | `string` | `""` | no |
| <a name="input_tunnel2_phase1_dh_group_numbers"></a> [tunnel2\_phase1\_dh\_group\_numbers](#input\_tunnel2\_phase1\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 | `list(number)` | `null` | no |
| <a name="input_tunnel2_phase1_encryption_algorithms"></a> [tunnel2\_phase1\_encryption\_algorithms](#input\_tunnel2\_phase1\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 | `list(string)` | `null` | no |
| <a name="input_tunnel2_phase1_integrity_algorithms"></a> [tunnel2\_phase1\_integrity\_algorithms](#input\_tunnel2\_phase1\_integrity\_algorithms) | (Optional) One or more integrity algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 | `list(string)` | `null` | no |
| <a name="input_tunnel2_phase1_lifetime_seconds"></a> [tunnel2\_phase1\_lifetime\_seconds](#input\_tunnel2\_phase1\_lifetime\_seconds) | (Optional, Default 28800) The lifetime for phase 1 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 28800 | `number` | `null` | no |
| <a name="input_tunnel2_phase2_dh_group_numbers"></a> [tunnel2\_phase2\_dh\_group\_numbers](#input\_tunnel2\_phase2\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 | `list(number)` | `null` | no |
| <a name="input_tunnel2_phase2_encryption_algorithms"></a> [tunnel2\_phase2\_encryption\_algorithms](#input\_tunnel2\_phase2\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 | `list(string)` | `null` | no |
| <a name="input_tunnel2_phase2_integrity_algorithms"></a> [tunnel2\_phase2\_integrity\_algorithms](#input\_tunnel2\_phase2\_integrity\_algorithms) | (Optional) List of one or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 | `list(string)` | `null` | no |
| <a name="input_tunnel2_phase2_lifetime_seconds"></a> [tunnel2\_phase2\_lifetime\_seconds](#input\_tunnel2\_phase2\_lifetime\_seconds) | (Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 3600 | `number` | `null` | no |
| <a name="input_tunnel2_preshared_key"></a> [tunnel2\_preshared\_key](#input\_tunnel2\_preshared\_key) | The preshared key of the second VPN tunnel. | `string` | `""` | no |
| <a name="input_tunnel2_rekey_fuzz_percentage"></a> [tunnel2\_rekey\_fuzz\_percentage](#input\_tunnel2\_rekey\_fuzz\_percentage) | (Optional, Default 100) The percentage of the rekey window for the second VPN tunnel (determined by tunnel1\_rekey\_margin\_time\_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100 | `number` | `null` | no |
| <a name="input_tunnel2_rekey_margin_time_seconds"></a> [tunnel2\_rekey\_margin\_time\_seconds](#input\_tunnel2\_rekey\_margin\_time\_seconds) | (Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the second VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel2\_rekey\_fuzz\_percentage. Valid value is between 60 and half of tunnel2\_phase2\_lifetime\_seconds | `number` | `null` | no |
| <a name="input_tunnel2_replay_window_size"></a> [tunnel2\_replay\_window\_size](#input\_tunnel2\_replay\_window\_size) | (Optional, Default 1024) The number of packets in an IKE replay window for the second VPN tunnel. Valid value is between 64 and 2048. | `number` | `null` | no |
| <a name="input_tunnel2_startup_action"></a> [tunnel2\_startup\_action](#input\_tunnel2\_startup\_action) | (Optional, Default add) The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the VPC where the VPN Gateway lives. | `string` | `null` | no |
| <a name="input_vpc_subnet_route_table_count"></a> [vpc\_subnet\_route\_table\_count](#input\_vpc\_subnet\_route\_table\_count) | The number of subnet route table ids being passed in via `vpc_subnet_route_table_ids`. | `number` | `0` | no |
| <a name="input_vpc_subnet_route_table_ids"></a> [vpc\_subnet\_route\_table\_ids](#input\_vpc\_subnet\_route\_table\_ids) | The ids of the VPC subnets for which routes from the VPN Gateway will be propagated. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_static_routes_destinations"></a> [vpn\_connection\_static\_routes\_destinations](#input\_vpn\_connection\_static\_routes\_destinations) | List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_static_routes_only"></a> [vpn\_connection\_static\_routes\_only](#input\_vpn\_connection\_static\_routes\_only) | Set to true for the created VPN connection to use static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP. | `bool` | `false` | no |
| <a name="input_vpn_gateway_id"></a> [vpn\_gateway\_id](#input\_vpn\_gateway\_id) | The id of the VPN Gateway. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tunnel1_preshared_key"></a> [tunnel1\_preshared\_key](#output\_tunnel1\_preshared\_key) | The preshared key of the first VPN tunnel. |
| <a name="output_tunnel2_preshared_key"></a> [tunnel2\_preshared\_key](#output\_tunnel2\_preshared\_key) | The preshared key of the second VPN tunnel. |
| <a name="output_vpn_connection_customer_gateway_configuration"></a> [vpn\_connection\_customer\_gateway\_configuration](#output\_vpn\_connection\_customer\_gateway\_configuration) | The configuration information for the VPN connection's customer gateway (in the native XML format) if `create_vpn_connection = true`, or empty otherwise |
| <a name="output_vpn_connection_id"></a> [vpn\_connection\_id](#output\_vpn\_connection\_id) | A list with the VPN Connection ID if `create_vpn_connection = true`, or empty otherwise |
| <a name="output_vpn_connection_transit_gateway_attachment_id"></a> [vpn\_connection\_transit\_gateway\_attachment\_id](#output\_vpn\_connection\_transit\_gateway\_attachment\_id) | The transit gateway attachment ID that was generated when attaching this VPN connection. |
| <a name="output_vpn_connection_tunnel1_address"></a> [vpn\_connection\_tunnel1\_address](#output\_vpn\_connection\_tunnel1\_address) | A list with the the public IP address of the first VPN tunnel if `create_vpn_connection = true`, or empty otherwise |
| <a name="output_vpn_connection_tunnel1_cgw_inside_address"></a> [vpn\_connection\_tunnel1\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_cgw\_inside\_address) | A list with the the RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
| <a name="output_vpn_connection_tunnel1_vgw_inside_address"></a> [vpn\_connection\_tunnel1\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_vgw\_inside\_address) | A list with the the RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
| <a name="output_vpn_connection_tunnel2_address"></a> [vpn\_connection\_tunnel2\_address](#output\_vpn\_connection\_tunnel2\_address) | A list with the the public IP address of the second VPN tunnel if `create_vpn_connection = true`, or empty otherwise |
| <a name="output_vpn_connection_tunnel2_cgw_inside_address"></a> [vpn\_connection\_tunnel2\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_cgw\_inside\_address) | A list with the the RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
| <a name="output_vpn_connection_tunnel2_vgw_inside_address"></a> [vpn\_connection\_tunnel2\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_vgw\_inside\_address) | A list with the the RFC 6890 link-local address of the second VPN tunnel (VPN Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master/LICENSE) for full details.
