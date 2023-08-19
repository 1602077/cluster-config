terraform {
  required_version = ">= 0.14.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
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

# #####################################################
# VPC
# #####################################################
module "vpc" {
  source = "../../modules/vpc"

  project_id  = var.project_id
  region      = var.region
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
}

# #####################################################
# GOOGLE KUBERNETES ENGINE
# #####################################################
module "gke" {
  source = "../../modules/gke"

  // cluster
  cluster_name = var.cluster_name
  project_id   = var.project_id
  zone         = var.zone
  vpc_name     = var.vpc_name
  subnet_name  = var.subnet_name

  // node pools
  primary_node_count = 1
}
