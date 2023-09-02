resource "google_compute_firewall" "crossplane-allow-ssh" {
  name    = "crossplane-allow-ssh"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "crossplane-allow-https" {
  name    = "crossplane-allow-https"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  source_ranges = ["0.0.0.0/0"]
}
