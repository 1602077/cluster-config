variable "project_id" {
  description = "gcp project id"
}

variable "zone" {
  description = "zone that cluster is located in"
  type        = string
}

variable "cluster_name" {
  description = "name of cluster, unique within project & zone"
}

variable "primary_node_count" {
  description = "initial node count of primary node pool"
}

variable "vpc_name" {
  description = "shared vpc for project"
}

variable "subnet_name" {
  description = "vpc subnet for project"
}

variable "gke_crypto_key_name" {
  description = "name of kms encryption key used to encrypt etcd"
}
