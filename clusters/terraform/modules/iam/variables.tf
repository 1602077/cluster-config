variable "project_id" {
  description = "gcp project id"
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
