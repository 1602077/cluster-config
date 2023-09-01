variable "cluster_name" {
  description = "name of cluster, unique within project & zone"
  type        = string
}

variable "zone" {
  description = "zone that cluster is located in. HA setup not required as only testing"
  type        = string
}

variable "crossplane_service_account_key" {
  description = "gcp service account key used by crossplane to provision resources"
  type        = string
}
