/**
 * # ENV specific dir
 *
 * IaC for specific env ( by dirname )
 */

module "aws_infra" {
  source = "../../modules/ecs-rds-infra"

  project_name     = "referral"
  db_name          = "CV"
  db_username      = "postgres"
  application_port = 8000
}
