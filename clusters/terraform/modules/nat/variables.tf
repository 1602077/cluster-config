variable "project_id" {
  description = "gcp project id"
  type        = string
}

variable "region" {
  description = "region that cluster and vpc are located in"
  type        = string
}

variable "nat_router_name" {
  description = "name of NAT router"
  type        = string
}

variable "vpc_name" {
  description = "shared vpc for project"
  type        = string
}
