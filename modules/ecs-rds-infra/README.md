<!-- BEGIN_TF_DOCS -->
# Module ecs-rds-infra

This code creates 2 VPCs, peering, ECS cluster, RDS instance

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db_dev"></a> [db\_dev](#module\_db\_dev) | terraform-aws-modules/rds/aws | ~> 4.1.0 |
| <a name="module_network_db"></a> [network\_db](#module\_network\_db) | terraform-aws-modules/vpc/aws | ~> 3.12.0 |
| <a name="module_network_ecs"></a> [network\_ecs](#module\_network\_ecs) | terraform-aws-modules/vpc/aws | ~> 3.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.referral](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_route.db_to_ecs_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.ecs_to_db_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.ecs_to_db_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [random_string.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.seed](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | Port which handle connection for your application | `number` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The DB name to create. If omitted, no database is created initially | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for the master DB user | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name that is used to tag all resources | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The port on which the DB accepts connections | `number` | `5432` | no |
| <a name="input_db_vpc_cidr"></a> [db\_vpc\_cidr](#input\_db\_vpc\_cidr) | CIDR for DB VPC to create | `string` | `"10.20.0.0/16"` | no |
| <a name="input_db_vpc_enable_dns_hostnames"></a> [db\_vpc\_enable\_dns\_hostnames](#input\_db\_vpc\_enable\_dns\_hostnames) | Should be true to enable DNS hostnames in the DB VPC | `bool` | `true` | no |
| <a name="input_db_vpc_public_subnets"></a> [db\_vpc\_public\_subnets](#input\_db\_vpc\_public\_subnets) | Database subnets of DB VPC | `list(string)` | <pre>[<br>  "10.20.0.0/24",<br>  "10.20.1.0/24",<br>  "10.20.2.0/24"<br>]</pre> | no |
| <a name="input_ecs_vpc_cidr"></a> [ecs\_vpc\_cidr](#input\_ecs\_vpc\_cidr) | CIDR for VPC to create | `string` | `"10.10.0.0/16"` | no |
| <a name="input_ecs_vpc_enable_dns_hostnames"></a> [ecs\_vpc\_enable\_dns\_hostnames](#input\_ecs\_vpc\_enable\_dns\_hostnames) | Should be true to enable DNS hostnames in the VPC | `bool` | `true` | no |
| <a name="input_ecs_vpc_enable_nat_gateway"></a> [ecs\_vpc\_enable\_nat\_gateway](#input\_ecs\_vpc\_enable\_nat\_gateway) | If true, creates NAT gateways | `bool` | `false` | no |
| <a name="input_ecs_vpc_public_subnets"></a> [ecs\_vpc\_public\_subnets](#input\_ecs\_vpc\_public\_subnets) | Public subnets of VPC | `list(string)` | <pre>[<br>  "10.10.0.0/24",<br>  "10.10.1.0/24",<br>  "10.10.2.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The connection endpoint of RDS instance |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | The database password |
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | The name of ECS cluster |
<!-- END_TF_DOCS -->