terraform {
  required_version = ">= 0.14.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
    }

    kubernetes = {
    }
  }

  backend "gcs" {
    bucket = "gitops-argo-terraform-state-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "provider" {}


# #####################################################
# GCP APIS
# #####################################################
module "apis" {
  source = "../modules/apis"

  project_id       = var.project_id
  gcp_service_list = var.gcp_service_list
}

# #####################################################
# IAM
# #####################################################
module "iam" {
  source = "../modules/iam"

  project_id                                 = var.project_id
  iam_crossplane_service_account_name        = var.iam_crossplane_service_account_name
  iam_crossplane_service_account_permissions = var.iam_crossplane_service_account_permissions
}

# #####################################################
# VPC
# #####################################################
module "vpc" {
  source     = "../modules/vpc"
  depends_on = [module.apis]

  project_id  = var.project_id
  region      = var.region
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
}

# #####################################################
# FIREWALL
# #####################################################
module "firewall" {
  source     = "../modules/firewall/"
  depends_on = [module.vpc]

  vpc_network_name = var.vpc_name
}

# #####################################################
# KMS
# #####################################################
module "kms" {
  source     = "../modules/kms"
  depends_on = [module.apis]

  region              = var.region
  kms_key_name        = var.kms_key_name
  kms_ring_name       = var.kms_ring_name
  kms_algorithm       = var.kms_algorithm
  kms_rotation_period = var.kms_rotation_period
}

# #####################################################
# BASTION HOST
# #####################################################
module "bastion" {
  source     = "../modules/bastion/"
  depends_on = [module.vpc]

  bastion_host_name         = var.bastion_host_name
  bastion_host_machine_type = var.bastion_host_machine_type
  zone                      = var.zone
  vpc_name                  = var.vpc_name
  subnet_name               = var.subnet_name
}

# #####################################################
# GOOGLE KUBERNETES ENGINE
# #####################################################
/*
module "gke" {
  source = "../modules/gke"
  depends_on = [
    module.apis,
    module.vpc,
    module.kms
  ]

  // cluster
  cluster_name = var.cluster_name
  project_id   = var.project_id
  zone         = var.zone
  vpc_name     = var.vpc_name
  subnet_name  = var.subnet_name

  // node pools
  primary_node_count = 1

  // security
  gke_crypto_key_name = module.kms.google_kms_crypto_key_name
}
/*

# #####################################################
# SOFTWARE / CROSSPLANE CONFIG
# #####################################################
/*
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

module "sofware-crossplane" {
  source = "../software/crossplane"
  depends_on = [
    module.gke,
    module.iam
  ]

  cluster_name = var.cluster_name
  zone         = var.zone

  crossplane_service_account_key = module.iam.crossplane_service_account_key
}
*/
