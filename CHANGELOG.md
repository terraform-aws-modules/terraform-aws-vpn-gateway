<a name="unreleased"></a>
## [Unreleased]



<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-10

- Typed the variables
- Update Readme with examples matching 0.12
- Whitespace o/
- Minimal example passses the plan
- Static route example passes plan
- Complete VPN example passes the plan.
- Complete dual examples passes the plan.
- Ran 012upgrade and restricted versions


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
- Merge pull request [#2](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/issues/2) from miguelaferreira/master
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


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/compare/v2.0.0...HEAD
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
