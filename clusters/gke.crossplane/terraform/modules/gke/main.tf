// Private gke cluster that will run "crossplane" to manage the provisioning
// of future clusters. This is a boostrapping instance.
resource "google_container_cluster" "crossplane" {
  name     = var.cluster_name
  location = var.zone
  /*
    Create smallest possible default node pool as it is going to be 
    immediately removed.
  */
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpc_name
  subnetwork               = var.subnet_name

  database_encryption {
    state    = "ENCRYPTED"
    key_name = var.gke_crypto_key_name
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.13.0.0/28"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.11.0.0/21"
    services_ipv4_cidr_block = "10.12.0.0/21"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.7/32"
      display_name = "net1"
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

// Primary node pool for "crossplane" cluster.
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.crossplane.name
  location = var.zone
  cluster  = google_container_cluster.crossplane.name

  node_count = var.primary_node_count

  autoscaling {
    min_node_count = "0"
    max_node_count = "3"
  }


  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      crossplane = "enabled"
    }

    preemptible  = true
    machine_type = "n1-standard-2"
    tags         = ["gke-node", "${var.project_id}-gke"]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  lifecycle {
    ignore_changes = [
      initial_node_count,
      node_count,
      version
    ]
  }
}
