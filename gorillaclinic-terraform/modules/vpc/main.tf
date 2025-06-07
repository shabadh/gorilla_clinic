#Create VPC
resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  project                 = var.project_id
}

#Create GCP Subnet
resource "google_compute_subnetwork" "subnet_eu" {
  name          = "gorillaclinic-subnet-eu"
  ip_cidr_range = var.ip_cidr_range_eu
  region        = var.region_eu
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "subnet_us" {
  name          = "gorillaclinic-subnet-us"
  ip_cidr_range = var.ip_cidr_range_us
  region        = var.region_us
  network       = google_compute_network.vpc.id
}