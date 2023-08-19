variable "project_id" {
  description = "gcp project id"
}

variable "region" {
  description = "region that cluster and vpc are located in"
  type        = string
}

variable "vpc_name" {
  description = "vpc subnet for project"
  default     = "gitops-argo-testing-subnet"
}

variable "subnet_name" {
  description = "vpc subnet for project"
  default     = "gitops-argo-testing-subnet"
}
