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

const (
	tunnel1PresharedKeyName  = "tunnel1_preshared_key"
	tunnel2PresharedKeyName  = "tunnel2_preshared_key"
	tunnel1InsideCidrName    = "tunnel1_inside_cidr"
	tunnel2InsideCidrName    = "tunnel2_inside_cidr"
	tunnel1PresharedKeyValue = "1234567890abcdefghijklmn"
	tunnel2PresharedKeyValue = "abcdefghijklmn1234567890"
	tunnel1InsideCidrValue   = "169.254.33.88/30"
	tunnel2InsideCidrValue   = "169.254.33.100/30"
)

type tunnelOptions map[string]string
type tfTestVars map[string]interface{}

func checkError(err error) {
	if err != nil {
		log.Fatalln(err)
	}
}

func getTunnelOptions(ec2Client ec2.Client, vpnConnectionId string) tunnelOptions {
	vpnConnectionsOutput, err := ec2Client.DescribeVpnConnections(
		context.TODO(), &ec2.DescribeVpnConnectionsInput{
			VpnConnectionIds: []string{vpnConnectionId},
		},
	)
	checkError(err)

	vpnConnectionOptions := vpnConnectionsOutput.VpnConnections[0].Options

	return tunnelOptions{
		tunnel1PresharedKeyName: *vpnConnectionOptions.TunnelOptions[0].PreSharedKey,
		tunnel2PresharedKeyName: *vpnConnectionOptions.TunnelOptions[1].PreSharedKey,
		tunnel1InsideCidrName:   *vpnConnectionOptions.TunnelOptions[0].TunnelInsideCidr,
		tunnel2InsideCidrName:   *vpnConnectionOptions.TunnelOptions[1].TunnelInsideCidr,
	}
}

func ValidateTunnelOptions(t *testing.T, tfTestVars map[string]interface{}, awsTunnelOptions tunnelOptions) {
	for awsKey, awsValue := range awsTunnelOptions {
		if tfValue, exists := tfTestVars[awsKey]; exists {
			assert.Equal(t, tfValue, awsValue)
		} else {
			assert.NotEmpty(t, awsValue)
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
				tunnel1PresharedKeyName: tunnel1PresharedKeyValue,
				tunnel2PresharedKeyName: tunnel2PresharedKeyValue,
			},
		},
		"tunnel_inside_cidr_only": {
			tfTestVars: tfTestVars{
				tunnel1InsideCidrName: tunnel1InsideCidrValue,
				tunnel2InsideCidrName: tunnel2InsideCidrValue,
			},
		},
		"preshared_keys_and_tunnel_inside_cidr": {
			tfTestVars: tfTestVars{
				tunnel1PresharedKeyName: tunnel1PresharedKeyValue,
				tunnel2PresharedKeyName: tunnel2PresharedKeyValue,
				tunnel1InsideCidrName:   tunnel1InsideCidrValue,
				tunnel2InsideCidrName:   tunnel2InsideCidrValue,
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

			tfVpnConnectionId := terraform.Output(t, terraformOptions, "vpn_connection_id")

			// Create a new AWS session using the default configuration (including AWS CLI credentials)
			cfg, err := config.LoadDefaultConfig(context.TODO())
			checkError(err)
			ec2Client := ec2.NewFromConfig(cfg)

			// validate the tunnel options
			awsTunnelOptions := getTunnelOptions(*ec2Client, tfVpnConnectionId)
			ValidateTunnelOptions(t, test.tfTestVars, awsTunnelOptions)
		})
	}
}
