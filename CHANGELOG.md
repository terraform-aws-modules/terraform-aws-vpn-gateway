# Changelog

All notable changes to this project will be documented in this file.

## [4.0.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.7.2...v4.0.0) (2024-12-20)


### ⚠ BREAKING CHANGES

* Enable acceleration support, raies MSV or Terraform and AWS provider (#99)

### Features

* Enable acceleration support, raies MSV or Terraform and AWS provider ([#99](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/99)) ([4f7c4d2](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/4f7c4d2459a7a4f15db7b84eb22f547e2d6563f9))


### Bug Fixes

* Update CI workflow versions to latest ([#100](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/100)) ([139920a](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/139920ae3e9176aa950523418797719408dec2b4))

## [3.7.2](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.7.1...v3.7.2) (2024-03-06)


### Bug Fixes

* Update CI workflow versions to remove deprecated runtime warnings ([#96](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/96)) ([5556636](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/555663627539853c292d4f209371b963f767661c))

### [3.7.1](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.7.0...v3.7.1) (2023-10-12)


### Bug Fixes

* Add `dpd_timeout_seconds` to `tunnel_preshared` ([#95](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/95)) ([21442a7](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/21442a7be49c123bc1bdf1701f92cebfa304219e))

## [3.7.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.6.0...v3.7.0) (2023-09-18)


### Features

* Added Transit Gateway Attachment tagging ([#92](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/92)) ([9f82005](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/9f820051996c46eca7c7b60cfb2b937f6cd4f502))

## [3.6.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.5.0...v3.6.0) (2023-06-26)


### Features

* Make PSK inputs as sensitive ([#91](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/91)) ([41e4d58](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/41e4d5820cb7c605d6da409e519449d52bb12639))

## [3.5.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.4.0...v3.5.0) (2023-06-06)


### Features

* Output the pre-shared tunnel keys even when they are auto-generated ([#89](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/89)) ([5ab7f2f](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/5ab7f2f6653da7c8ad9d9bd2f86e758a061bee42))

## [3.4.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.3.0...v3.4.0) (2023-05-18)


### Features

* Add `enable_tunnel_lifecycle_control` arguments ([#88](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/88)) ([23dec42](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/23dec42171e76d4cd8b59b70a21105df8a849774))

## [3.3.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.2.0...v3.3.0) (2023-03-06)


### Features

* Set tunnel PSK outputs to `sensitive = true` ([#86](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/86)) ([4b0db3b](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/4b0db3b4b30c4bfa1cb406b42c6bd2d3177c7a43))

## [3.2.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.1.1...v3.2.0) (2023-01-27)


### Features

* Set `vpn_connection_customer_gateway_configuration` output to `sensitive = true` ([#83](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/83)) ([cd02770](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/cd0277072676c87d86c7b277e54e262b424af5cb))

### [3.1.1](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.1.0...v3.1.1) (2023-01-24)


### Bug Fixes

* Use a version for  to avoid GitHub API rate limiting on CI workflows ([#82](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/82)) ([374ad66](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/374ad667b328f9b95536a8874ddfc4568542af2e))

## [3.1.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.0.1...v3.1.0) (2022-11-15)


### Features

* Added logging ([#76](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/76)) ([ba043a6](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/ba043a64bc8378eb3043e65737bf9d6f9910cdbe))

### [3.0.1](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v3.0.0...v3.0.1) (2022-11-15)


### Bug Fixes

* Fixed outputs (removed coalesce) ([#79](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/79)) ([1dbcd86](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/1dbcd862c3872e0fb87447e5f18b5273a1034108))

## [3.0.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.12.1...v3.0.0) (2022-11-12)


### ⚠ BREAKING CHANGES

* Update supported Terraform min version to v1.0+ and AWS provider to v4.0+ (#77)

### Features

* Update supported Terraform min version to v1.0+ and AWS provider to v4.0+ ([#77](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/77)) ([b7db0ba](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/b7db0ba561244fb21075b56a52410f5fcd92009b))

### [2.12.1](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.12.0...v2.12.1) (2022-06-14)


### Bug Fixes

* Fixed default CIDR values for both ipv4 and ipv6 ([#70](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/70)) ([3eac796](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/3eac796d6793bf1d657ed8466f5e3ee9ef7b3ef9))

## [2.12.0](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.11.1...v2.12.0) (2022-06-10)


### Features

* Add support for ipv6 ([#66](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/66)) ([32dacc2](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/32dacc2dfe2ccc3e6a18e0b1eeee7892b7f7ea29))

### [2.11.1](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.11.0...v2.11.1) (2022-01-10)


### Bug Fixes

* update CI/CD process to enable auto-release workflow ([#60](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/60)) ([706ce3b](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/commit/706ce3b48ac0dd789b711ede93e3dac366c6b1ab))

<a name="v2.11.0"></a>
## [v2.11.0] - 2021-08-19

- feat: Add support for local and remote ipv4 cidr ([#58](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/58))


<a name="v2.10.0"></a>
## [v2.10.0] - 2021-05-22

- feat: adding preshared key outputs to module ([#55](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/55))
- chore: update CI/CD to use stable `terraform-docs` release artifact and discoverable Apache2.0 license ([#57](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/57))


<a name="v2.9.0"></a>
## [v2.9.0] - 2021-04-28

- chore: Updated versions in README ([#56](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/56))
- chore: update documentation and pin `terraform_docs` version to avoid future changes ([#52](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/52))


<a name="v2.8.0"></a>
## [v2.8.0] - 2021-03-25

- feat: Added dpd_timeout_seconds variable to the "default" tunnel resource ([#51](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/51))
- chore: align ci-cd static checks to use individual minimum Terraform versions ([#50](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/50))
- chore: Run pre-commit hooks ([#49](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/49))
- chore: add ci-cd workflow for pre-commit checks ([#48](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/48))


<a name="v2.7.0"></a>
## [v2.7.0] - 2021-02-20

- chore: update documentation based on latest `terraform-docs` which includes module and resource sections ([#47](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/47))


<a name="v2.6.0"></a>
## [v2.6.0] - 2021-02-15

- feat: Added VPN connection additional args ([#46](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/46))


<a name="v2.5.0"></a>
## [v2.5.0] - 2020-01-16

- Fixed count and computed values bug


<a name="v2.4.0"></a>
## [v2.4.0] - 2020-01-15

- Add support for Transit Gateway ([#26](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/26))
- Also output the connection configuration ([#28](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/28))
- Updated README and pre-commit
- Updated example with variables ([#24](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/24))
- Fixed aws_vpn_connection_route conditional expression
- Upgraded module to support Terraform 0.12 ([#20](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/20))


<a name="v1.8.0"></a>
## [v1.8.0] - 2019-12-19

- Also output the connection configuration ([#29](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/29))
- Fixed formatting after [#25](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/25)
- Terraform011 ([#25](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/25))


<a name="v2.3.0"></a>
## [v2.3.0] - 2019-12-19

- Also output the connection configuration ([#28](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/28))
- Updated README and pre-commit
- Updated example with variables ([#24](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/24))
- Fixed aws_vpn_connection_route conditional expression
- Upgraded module to support Terraform 0.12 ([#20](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/20))


<a name="v1.7.0"></a>
## [v1.7.0] - 2019-08-23

- Fixed formatting after [#25](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/25)
- Terraform011 ([#25](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/25))


<a name="v2.2.0"></a>
## [v2.2.0] - 2019-08-23



<a name="v2.1.0"></a>
## [v2.1.0] - 2019-08-22

- Updated README and pre-commit
- Updated example with variables ([#24](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/24))


<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-11

- Fixed aws_vpn_connection_route conditional expression
- Upgraded module to support Terraform 0.12 ([#20](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/20))


<a name="v1.6.1"></a>
## [v1.6.1] - 2018-11-16

- Fix format ([#16](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/16))


<a name="v1.6.0"></a>
## [v1.6.0] - 2018-10-31

- Select appropriate VPN connection for routes resource ([#15](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/15))
- Fixing readme to reflect reality. ([#12](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/12))

###

"tunnel1_preshared_key" can only contain alphanumeric, period and
underscore characters

"tunnel1_preshared_key" cannot start with zero character

"tunnel2_preshared_key" can only contain alphanumeric, period and
underscore characters

* Define AWS region in examples and make it mutually exclusive

* Explicitely define non string vriable type

* Add comment to default VPN connection for consistency

* Add missing condition to use tunnel_preshared vpn connection resource in routes


<a name="v1.5.0"></a>
## [v1.5.0] - 2018-09-07

- Formatting fixes after [#11](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/11)
- Fix vpn connection setup while tunnel cidr is used ([#11](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/11))


<a name="v1.4.0"></a>
## [v1.4.0] - 2018-08-18

- Only do gateway attachments when we are actually creating ([#10](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/10))


<a name="v1.3.0"></a>
## [v1.3.0] - 2018-05-16

- Added pre-commit hook to autogenerate terraform-docs


<a name="v1.2.0"></a>
## [v1.2.0] - 2018-05-09

- Adding Tunnel1/2 Inside CIDR and Preshared Key ([#6](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/6)) ([#9](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/9))


<a name="v1.1.0"></a>
## [v1.1.0] - 2018-04-22

- Ability to override default 'Name' tag ([#8](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/8))


<a name="v1.0.3"></a>
## [v1.0.3] - 2018-01-11

- Document conditions for using VPN connection routes ([#5](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/5))


<a name="v1.0.2"></a>
## [v1.0.2] - 2018-01-11

- Fix issue with computed resources used for count attribute ([#4](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/4))


<a name="v1.0.0"></a>
## [v1.0.0] - 2018-01-10

- Added License file


<a name="v1.0.1"></a>
## v1.0.1 - 2018-01-10

- Fixed bugs, updated examples, readme
- Add static routes
- Add examples
- Add outputs
- Add descriptions to variables
- Add 2 variables to completely configure VPN connection resource
- Add variable to specify customer gateway id
- Add boolean variable to enable/disable creaation of VPN connection
- Add link to VPC module
- Add links to resource documentation
- Document usage module usage with and without VPC module
- Initial setup of VPN Gateway for AWS VPCs
- Initial commit
- Initial commit


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.11.0...HEAD
[v2.11.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.10.0...v2.11.0
[v2.10.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.9.0...v2.10.0
[v2.9.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.8.0...v2.9.0
[v2.8.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.7.0...v2.8.0
[v2.7.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.6.0...v2.7.0
[v2.6.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.5.0...v2.6.0
[v2.5.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.4.0...v2.5.0
[v2.4.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.8.0...v2.4.0
[v1.8.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.3.0...v1.8.0
[v2.3.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.7.0...v2.3.0
[v1.7.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.2.0...v1.7.0
[v2.2.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.1.0...v2.2.0
[v2.1.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.0.0...v2.1.0
[v2.0.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.6.1...v2.0.0
[v1.6.1]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.6.0...v1.6.1
[v1.6.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.5.0...v1.6.0
[v1.5.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.4.0...v1.5.0
[v1.4.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.3.0...v1.4.0
[v1.3.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.2.0...v1.3.0
[v1.2.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.0.3...v1.1.0
[v1.0.3]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.0.2...v1.0.3
[v1.0.2]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.0.0...v1.0.2
[v1.0.0]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v1.0.1...v1.0.0
