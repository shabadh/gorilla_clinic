# #Create VPC
# resource "google_compute_network" "vpc" {
#   name                    = var.network_name
#   auto_create_subnetworks = var.auto_create_subnetworks
#   project                 = var.project_id
# }

# #Create GCP Subnet
# resource "google_compute_subnetwork" "subnet_eu" {
#   name          = "gorillaclinic-subnet-eu"
#   ip_cidr_range = var.ip_cidr_range_eu
#   region        = var.region_eu
#   network       = google_compute_network.vpc.id
#   project       = var.project_id
# }

# resource "google_compute_subnetwork" "subnet_us" {
#   name          = "gorillaclinic-subnet-us"
#   ip_cidr_range = var.ip_cidr_range_us
#   region        = var.region_us
#   network       = google_compute_network.vpc.id
#   project       = var.project_id
# }

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = { for subnet in var.subnets : subnet.name => subnet }
  name          = each.value.name
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.vpc.id
  project       = var.project_id
}
