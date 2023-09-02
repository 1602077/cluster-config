output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "crossplane_service_account_key" {
  value     = module.iam.crossplane_service_account_key
  sensitive = true
}
