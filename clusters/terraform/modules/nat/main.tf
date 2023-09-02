resource "google_compute_router" "router" {
  project = var.project_id
  name    = var.nat_router_name
  network = var.vpc_name
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = var.nat_router_name
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
