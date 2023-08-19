data "google_client_config" "provider" {}

data "google_container_cluster" "crossplane" {
  name     = var.cluster_name
  location = var.zone
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.crossplane.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.crossplane.master_auth[0].cluster_ca_certificate,
  )
}
