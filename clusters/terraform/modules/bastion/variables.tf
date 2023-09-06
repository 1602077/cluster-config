variable "project_id" {
  description = "gcp project id"
  type        = string
}

variable "zone" {
  description = "zone that cluster is located in. HA setup not required as only testing"
  type        = string
}

variable "bastion_host_name" {
  description = "name of bastion host"
  type        = string
}

variable "bastion_host_machine_type" {
  description = "gcp machine instance for bastion host vm"
  type        = string
}

variable "bastion_host_members" {
  description = "members authorised to log in to bastion host"
  type        = list(string)
}

variable "vpc_name" {
  description = "shared vpc for project"
  type        = string
}

variable "subnet_name" {
  description = "vpc subnet for project"
  type        = string
}
