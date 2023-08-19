variable "project_id" {
  description = "gcp project id"
  type        = string
}

variable "region" {
  description = "region that cluster and vpc are located in"
  type        = string
}

variable "cluster_name" {
  description = "name of cluster, unique within project & zone"
  default     = "primary"
  type        = string
}


variable "primary_node_count" {
  description = "initial node count of primary node pool"
  default     = 1
}

variable "vpc_name" {
  description = "shared vpc for project"
  default     = "gitops-argo-testing"
  type        = string
}

variable "subnet_name" {
  description = "vpc subnet for project"
  default     = "gitops-argo-testing-subnet"
  type        = string
}
