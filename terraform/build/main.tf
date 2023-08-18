provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_version = ">= 0.14.0"
}

module "vpc" {
  source = "../modules/vpc"

  project_id  = var.project_id
  region      = var.region
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
}

module "gke_cluster" {
  source = "../modules/gke"

  project_id  = var.project_id
  region      = var.region
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name

}
