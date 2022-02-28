# ECS Network
variable "ecs_vpc_cidr" {
  description = "CIDR for VPC to create"
  type        = string
  default     = "10.10.0.0/16"
}

variable "ecs_vpc_public_subnets" {
  description = "Public subnets of VPC"
  type        = list(string)
  default     = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24"]
}

variable "ecs_vpc_enable_nat_gateway" {
  description = "If true, creates NAT gateways"
  type        = bool
  default     = false
}

variable "ecs_vpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
