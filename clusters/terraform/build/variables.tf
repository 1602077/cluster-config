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

variable "gcp_service_list" {
  description = "required gcp apis for project"
  type        = list(string)
  default = [
    "autoscaling.googleapis.com",
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "dns.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "networkconnectivity.googleapis.com",
    "serviceusage.googleapis.com"
  ]
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

variable "iam_crossplane_service_account_name" {
  description = "name of service account used in gke to run crossplane"
  type        = string
}

variable "iam_crossplane_service_account_permissions" {
  description = "permissions assigne to iam_crossplane_service_account_name"
  type        = list(string)
}

variable "bastion_host_name" {
  description = "name of bastion host"
  type        = string
}

variable "bastion_host_machine_type" {
  description = "gcp machine instance for bastion host vm"
  type        = string
}
