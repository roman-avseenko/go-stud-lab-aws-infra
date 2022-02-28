data "aws_availability_zones" "available" {}

module "network_ecs" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.12.0"

  name = local.network_ecs_name
  cidr = var.ecs_vpc_cidr
  azs  = data.aws_availability_zones.available.names

  # NAT-related
  enable_nat_gateway = var.ecs_vpc_enable_nat_gateway

  # DNS hostnames in VPC
  enable_dns_hostnames = var.ecs_vpc_enable_dns_hostnames

  # Subnets
  public_subnets = var.ecs_vpc_public_subnets

  manage_default_security_group = true
  default_security_group_ingress = [
    {
      cidr_blocks = var.db_vpc_cidr
      from_port   = var.db_port
      to_port     = var.db_port
      protocol    = "tcp"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      from_port   = var.application_port
      to_port     = var.application_port
      protocol    = "tcp"
    }
  ]

  default_security_group_egress = [{
    cidr_blocks = "0.0.0.0/0"
  }]

  tags = merge(tomap({
    # Place additional tags for VPC here
    }),
    local.common_tags
  )
}


module "network_db" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.12.0"

  name = local.network_db_name
  cidr = var.db_vpc_cidr
  azs  = data.aws_availability_zones.available.names

  # DNS hostnames in VPC
  enable_dns_hostnames = var.db_vpc_enable_dns_hostnames

  # Subnets
  public_subnets = var.db_vpc_public_subnets

  # Allow inbound traffic for DB
  manage_default_security_group = true
  default_security_group_ingress = [{
    cidr_blocks = var.ecs_vpc_cidr
    protocol    = "tcp"
    from_port   = var.db_port
    to_port     = var.db_port
  }]

  default_security_group_egress = [{
    cidr_blocks = var.ecs_vpc_cidr
  }]

  tags = merge(tomap({
    # Place additional tags for VPC here
    }),
    local.common_tags
  )
}

# VPC peering related ------------------------------------------------------------------
resource "aws_vpc_peering_connection" "ecs_to_db_peer" {
  vpc_id      = module.network_ecs.vpc_id
  peer_vpc_id = module.network_db.vpc_id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name = local.peering_con_name
  }
}

resource "aws_route" "ecs_to_db_vpc" {
  depends_on = [aws_vpc_peering_connection.ecs_to_db_peer, module.network_ecs, module.network_db]
  count      = length(module.network_ecs.public_route_table_ids)

  route_table_id            = module.network_ecs.public_route_table_ids[count.index]
  destination_cidr_block    = var.db_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.ecs_to_db_peer.id

  timeouts {
    create = "5m"
    delete = "5m"
  }
}

resource "aws_route" "db_to_ecs_vpc" {
  depends_on = [aws_vpc_peering_connection.ecs_to_db_peer, module.network_ecs, module.network_db]
  count      = length(module.network_db.public_route_table_ids)

  route_table_id            = module.network_db.public_route_table_ids[count.index]
  destination_cidr_block    = var.ecs_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.ecs_to_db_peer.id

  timeouts {
    create = "5m"
    delete = "5m"
  }
}
