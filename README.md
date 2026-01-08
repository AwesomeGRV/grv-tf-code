# AWS Multi-VPC Infrastructure with Transit Gateway

This Terraform module creates a comprehensive multi-VPC infrastructure setup on AWS with Transit Gateway for inter-VPC communication. The architecture includes three separate environments: Development, Management, and Production, each with their own VPCs and networking components.

## Architecture Overview

The infrastructure creates the following components:

### Environments
- **Development VPC** (10.0.0.0/16)
  - 2 Public Subnets (10.0.1.0/24, 10.0.2.0/24)
  - 2 Private Subnets (10.0.3.0/24, 10.0.4.0/24)
  
- **Management VPC** (20.0.0.0/16)
  - 2 Public Subnets (20.0.1.0/24, 20.0.2.0/24)
  - 2 Private Subnets (20.0.3.0/24, 20.0.4.0/24)
  - Internet Gateway and NAT Gateways for internet access
  
- **Production VPC** (30.0.0.0/16)
  - 2 Public Subnets (30.0.1.0/24, 30.0.2.0/24)
  - 2 Private Subnets (30.0.3.0/24, 30.0.4.0/24)

### Networking Components
- **Transit Gateway**: Central hub for inter-VPC communication
- **VPC Flow Logs**: Comprehensive logging for all VPCs
- **Route Tables**: Configured for proper traffic routing between VPCs
- **NAT Gateways**: For private subnet internet access (Management VPC only)

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate permissions
- IAM permissions for:
  - VPC management
  - Transit Gateway operations
  - IAM role and policy creation
  - CloudWatch Logs

## Usage

### Basic Deployment

1. Clone the repository:
```bash
git clone <repository-url>
cd grv-tf-code
```

2. Initialize Terraform:
```bash
terraform init
```

3. Review and customize variables (optional):
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

4. Plan the deployment:
```bash
terraform plan
```

5. Apply the configuration:
```bash
terraform apply
```

### Customization

You can customize the deployment by modifying the following:

#### Region Configuration
Change the AWS region by updating the `aws_region` variable:
```hcl
variable "aws_region" {
  default = "us-west-2"
}
```

#### CIDR Blocks
Modify the CIDR blocks in `main.tf` locals section:
```hcl
locals {
  dev_cidr     = "10.0.0.0/16"
  manage_cidr  = "20.0.0.0/16"
  prod_cidr    = "30.0.0.0/16"
}
```

#### Availability Zones
Update availability zones as needed for your region:
```hcl
locals {
  avail_zone         = ["us-east-1a", "us-east-1b"]
  private_avail_zone = ["us-east-1c", "us-east-1d"]
}
```

## Module Structure

```
.
├── main.tf                 # Main configuration file
├── variables.tf           # Input variables
├── outputs.tf             # Output values
├── providers.tf           # AWS provider configuration
├── modules/
│   ├── vpc/              # VPC creation module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc-configs/      # VPC configurations (Flow Logs)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── transit-gateway/  # Transit Gateway module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

## Variables

### Input Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| aws_region | AWS region where resources will be deployed | string | us-east-1 |

### Output Variables

The module outputs the following values:

- VPC IDs for all environments
- Subnet IDs for all environments
- Route table IDs for all environments
- CloudWatch Log Group ARNs for VPC flow logs

## Security Considerations

- All resources are tagged with consistent naming conventions
- VPC Flow Logs are enabled for all VPCs with 90-day retention
- IAM roles follow least privilege principle
- Network traffic between VPCs is controlled via Transit Gateway routing

## Cost Management

- Monitor Transit Gateway data transfer costs
- CloudWatch Logs retention is set to 90 days (adjustable)
- NAT Gateway costs apply to Management VPC only

## Monitoring and Logging

- VPC Flow Logs are sent to CloudWatch Logs
- All resources are tagged for cost allocation
- Consider setting up CloudWatch Alarms for monitoring

## Maintenance

### Regular Tasks
- Review and update CIDR allocations as needed
- Monitor Transit Gateway attachment status
- Update IAM policies as requirements change
- Review CloudWatch log retention policies

### Troubleshooting

Common issues and solutions:

1. **Transit Gateway Attachment Failures**
   - Verify subnet IDs are correct
   - Check VPC CIDR overlaps
   - Ensure proper IAM permissions

2. **Route Table Updates**
   - Verify route table IDs are correct
   - Check for conflicting routes
   - Ensure Transit Gateway is properly attached

3. **VPC Flow Logs Issues**
   - Verify IAM role permissions
   - Check CloudWatch Log Group configuration
   - Ensure VPC ID is correct

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For issues and questions:
- Check the troubleshooting section
- Review AWS documentation for Transit Gateway
- Create an issue in the repository

## Version History

- v1.0.0 - Initial production-ready release with comprehensive tagging and validation
