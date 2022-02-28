/**
 * # Module ecs-rds-infra
 *
 * This code creates 2 VPCs, peering, ECS cluster, RDS instance
 */

resource "aws_ecs_cluster" "referral" {
  name = local.ecs_cluster_name
}

module "db_dev" {
  depends_on = [module.network_db]
  source     = "terraform-aws-modules/rds/aws"
  version    = "~> 4.1.0"
  identifier = local.rds_db_name

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = "14.1"
  family               = "postgres14" # DB parameter group
  major_engine_version = "14"         # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = false

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  db_name                = var.db_name
  username               = var.db_username
  create_random_password = false
  password               = local.rds_db_password
  port                   = var.db_port

  create_db_subnet_group = true
  db_subnet_group_name   = local.rds_db_name

  publicly_accessible = true

  multi_az               = false
  subnet_ids             = module.network_db.public_subnets
  vpc_security_group_ids = [module.network_db.default_security_group_id]

  tags = merge(tomap({

    }),
    local.common_tags
  )
}
