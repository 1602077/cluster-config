variable "cluster_name" {
  description = "name of cluster, unique within project & zone"
  type        = string
}

variable "zone" {
  description = "zone that cluster is located in. HA setup not required as only testing"
  type        = string
}
