data "google_project" "project" {}

resource "google_kms_key_ring" "keyring" {
  name     = var.kms_ring_name
  location = var.region
}

resource "google_kms_crypto_key" "key" {
  name            = var.kms_key_name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.kms_rotation_period

  version_template {
    algorithm = var.kms_algorithm
  }
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"
  ]
}
