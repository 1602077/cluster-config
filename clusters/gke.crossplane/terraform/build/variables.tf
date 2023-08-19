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

variable "kms_key_name" {
  description = "name of the KMS key"
  type        = string
}

variable "kms_ring_name" {
  description = "name of the KMS Keyring"
  type        = string

}

variable "kms_algorithm" {
  description = "algorithm for the KMS key"
  type        = string
}

variable "kms_rotation_period" {
  description = "Time in seconds to rotate key"
  type        = string
}
