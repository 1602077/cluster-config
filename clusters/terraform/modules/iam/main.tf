resource "google_service_account" "crossplane_sa" {
  account_id   = var.iam_crossplane_service_account_name
  display_name = var.iam_crossplane_service_account_name
}

resource "google_project_iam_member" "crossplane_sa_perms" {
  for_each = toset(var.iam_crossplane_service_account_permissions)
  project  = var.project_id
  member   = "serviceAccount:${google_service_account.crossplane_sa.email}"
  role     = each.value
}
