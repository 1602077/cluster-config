resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  depends_on    = [google_compute_network.vpc]
  name          = var.subnet_name
  region        = var.region
  network       = var.vpc_name
  ip_cidr_range = "10.0.0.0/24"
}
