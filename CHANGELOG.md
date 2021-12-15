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
