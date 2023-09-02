resource "google_compute_firewall" "crossplane-allow-ssh" {
  name    = "${var.vpc_network_name}-allow-ssh"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "crossplane-allow-https" {
  name    = "${var.vpc_network_name}-allow-https"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "crossplane-allow-istio" {
  name    = "${var.vpc_network_name}-allow-istio"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports = [
      "10250",
      "15017",
      "443"
    ]
  }

  source_ranges = ["0.0.0.0/0"]
}
