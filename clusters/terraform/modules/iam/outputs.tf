output "crossplane_service_account_key" {
  value     = google_service_account_key.crossplane.private_key
  sensitive = true
}
