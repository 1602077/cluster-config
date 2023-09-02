resource "google_compute_instance" "bastion_host" {
  name         = var.bastion_host_name
  machine_type = var.bastion_host_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name

    access_config {
      network_tier = "STANDARD"
    }
  }

  scheduling {
    preemptible = true
  }
}
