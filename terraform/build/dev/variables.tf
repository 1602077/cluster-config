variable "project_id" {
  description = "gcp project id"
  type        = string
}

variable "zone" {
  description = "zone that cluster is located in. HA setup not required as only testing"
  type        = string
}

variable "region" {
  description = "region that cluster and vpc are located in"
  type        = string
}

variable "cluster_name" {
  description = "name of cluster, unique within project & zone"
  type        = string
}


variable "primary_node_count" {
  description = "initial node count of primary node pool"
  type        = string
}

variable "vpc_name" {
  description = "shared vpc for project"
  type        = string
}

variable "subnet_name" {
  description = "vpc subnet for project"
  type        = string
}
