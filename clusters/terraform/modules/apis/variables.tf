variable "project_id" {
  description = "gcp project id"
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
