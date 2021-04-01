# Terraform AWS Account Module

## Assumptions
* Service Control Policies have been created to limit who has access to change Routing, NACLs and Security Groups.
* Guard Duty Admin Account is created and configured.
* NAT Gateway and Internet Gateway have been left out without knowing setup with an egress account.
* Add VPC Endpoints as needed but put commonly needed ones.

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| region | string | us-east-1 | Region to create resources in |
| account_name | string | N/A | Name of the account |
| email | string | N/A | Email to use for the account |
| parent_id | string | N/A | Organization/Unit parent identifier |
| flow_log_retention | number | 90 | How long to keep flowlogs in cloudwatch |
| cidr_block | string | N/A | Main CIDR Block to assign to VPC |
| public_a_cidr_block | string | N/A | CIDR Block for public subnet should be a /28 |
| public_b_cidr_block | string | N/A | CIDR Block for public subnet should be a /28 |
| public_c_cidr_block | string | N/A | CIDR Block for public subnet should be a /28 |
| private_a_cidr_block | string | N/A | CIDR Block for private subnet |
| private_b_cidr_block | string | N/A | CIDR Block for private subnet |
| private_c_cidr_block | string | N/A | CIDR Block for private subnet |
| pod_cidr_enabled | bool | false | Whether to enable secondary cidr for pods |
| pod_cidr_block | string | 100.64.0.0/16 | Secondary CIDR Block for pods |
| pod_a_cidr_block | string | N/A | CIDR Block for pod subnet |
| pod_b_cidr_block | string | N/A | CIDR Block for pod subnet |
| pod_c_cidr_block | string | N/A | CIDR Block for pod subnet |
| tags | map(string) | N/A | Common tags to apply to all resources |

## Example

```terraform
module "production" {
  source = ""
  cidr_block = "10.0.64.0/21"
  public_a_cidr_block = "10.0.64.0/28"
  public_b_cidr_block = "10.0.64.16/28"
  public_c_cidr_block = "10.0.64.32/28"
  private_a_cidr_block = "10.0.65.0/24"
  private_b_cidr_block = "10.0.66.0/24"
  private_c_cidr_block = "10.0.67.0/24"
  pod_cidr_enabled = true
  pod_a_cidr_block = "100.64.0.0/18"
  pod_b_cidr_block = "100.64.64.0/18"
  pod_b_cidr_block = "100.64.128.0/18"
}
```