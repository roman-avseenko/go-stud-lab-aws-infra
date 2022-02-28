# DB Network
variable "db_vpc_cidr" {
  description = "CIDR for DB VPC to create"
  type        = string
  default     = "10.20.0.0/16"
}

variable "db_vpc_public_subnets" {
  description = "Database subnets of DB VPC"
  type        = list(string)
  default     = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"]
}

variable "db_vpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the DB VPC"
  type        = bool
  default     = true
}

#DB parameters
variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}
