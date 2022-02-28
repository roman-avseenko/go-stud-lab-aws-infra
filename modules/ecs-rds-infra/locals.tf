resource "random_string" "seed" {
  length      = 8
  lower       = true
  min_lower   = 4
  number      = true
  min_numeric = 4
}

resource "random_string" "db_password" {
  length      = 16
  lower       = true
  min_lower   = 5
  upper       = true
  min_upper   = 5
  number      = true
  min_numeric = 6
}

locals {
  # get workdir as list ( e.g. ) "/tmp/tf/envs/dev"
  pwd_list = split("/", path.cwd)
  # get just dirname "dev"
  pwd_clear = element(local.pwd_list, length(local.pwd_list) - 1)
  # assign to env var
  env = local.pwd_clear

  network_ecs_name = "${var.project_name}-vpc-ecs-${local.env}-${random_string.seed.result}"
  network_db_name  = "${var.project_name}-vpc-db-${local.env}-${random_string.seed.result}"
  peering_con_name = "${var.project_name}-peer-${local.env}-${random_string.seed.result}"
  ecs_cluster_name = "${var.project_name}-ecs-${local.env}-${random_string.seed.result}"
  rds_db_name      = "${var.project_name}-db-${local.env}-${random_string.seed.result}"
  rds_db_password  = random_string.db_password.result

  common_tags = {
    project     = var.project_name
    environment = local.env
    iac         = "terraform"
  }
}
