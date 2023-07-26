package test

import (
	"context"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/ec2"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"log"
	"testing"
)

var tunnel1PresharedKey = "1234567890abcdefghijklmn"
var tunnel2PresharedKey = "abcdefghijklmn1234567890"
var tunnel1InsideCidr = "169.254.33.88/30"
var tunnel2InsideCidr = "169.254.33.100/30"

func checkError(err error) {
	if err != nil {
		log.Fatalln(err)
	}
}

type tunnelOptions map[string]string
type tfTestVars map[string]interface{}

func tunnelOptionsCheck(t *testing.T, tfTestVars map[string]interface{}, awsTunnelOptions tunnelOptions) {
	for k, v := range awsTunnelOptions {
		if value, exists := tfTestVars[k]; exists {
			assert.Equal(t, value, v)
		} else {
			assert.NotEmpty(t, v)
		}
	}
}

func TestCompleteVpnGateway(t *testing.T) {
	tests := map[string]struct {
		tfTestVars tfTestVars
	}{
		"default": {
			tfTestVars: tfTestVars{},
		},
		"preshared_keys_only": {
			tfTestVars: tfTestVars{
				"tunnel1_preshared_key": tunnel1PresharedKey,
				"tunnel2_preshared_key": tunnel2PresharedKey,
			},
		},
		"tunnel_inside_cidr_only": {
			tfTestVars: tfTestVars{
				"tunnel1_inside_cidr": tunnel1InsideCidr,
				"tunnel2_inside_cidr": tunnel2InsideCidr,
			},
		},
		"preshared_keys_and_tunnel_inside_cidr": {
			tfTestVars: tfTestVars{
				"tunnel1_preshared_key": tunnel1PresharedKey,
				"tunnel2_preshared_key": tunnel2PresharedKey,
				"tunnel1_inside_cidr":   tunnel1InsideCidr,
				"tunnel2_inside_cidr":   tunnel2InsideCidr,
			},
		},
	}
	for name, test := range tests {
		log.Println(test)
		t.Run(name, func(t *testing.T) {

			terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
				TerraformDir: "../examples/complete-vpn-gateway",
				Vars:         test.tfTestVars,
				NoColor:      true,
			})

			defer terraform.Destroy(t, terraformOptions)
			terraform.InitAndApply(t, terraformOptions)

			tf_vpn_connection_id := terraform.Output(t, terraformOptions, "vpn_connection_id")

			// Create a new AWS session using the default configuration (including AWS CLI credentials)
			cfg, err := config.LoadDefaultConfig(context.TODO())
			checkError(err)

			// create service clients
			ec2Client := ec2.NewFromConfig(cfg)

			vpnConnectionsOutput, err := ec2Client.DescribeVpnConnections(
				context.TODO(), &ec2.DescribeVpnConnectionsInput{
					VpnConnectionIds: []string{tf_vpn_connection_id},
				},
			)
			checkError(err)

			vpnConnectionOptions := vpnConnectionsOutput.VpnConnections[0].Options
			awsTunnelOptions := tunnelOptions{
				"tunnel1_preshared_key": *vpnConnectionOptions.TunnelOptions[0].PreSharedKey,
				"tunnel2_preshared_key": *vpnConnectionOptions.TunnelOptions[1].PreSharedKey,
				"tunnel1_inside_cidr":   *vpnConnectionOptions.TunnelOptions[0].TunnelInsideCidr,
				"tunnel2_inside_cidr":   *vpnConnectionOptions.TunnelOptions[1].TunnelInsideCidr,
			}

			tunnelOptionsCheck(t, test.tfTestVars, awsTunnelOptions)
		})
	}
}
