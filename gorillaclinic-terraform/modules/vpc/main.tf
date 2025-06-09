resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnets" {
  count         = length(var.regions)
  name          = "subnet-${var.regions[count.index]}"
  ip_cidr_range = "10.${count.index}.0.0/16"
  region        = var.regions[count.index]
  network       = google_compute_network.vpc.id
  project       = var.project_id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "172.16.${count.index * 16}.0/20"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "172.17.${count.index * 16}.0/20"
  }
}

resource "google_compute_global_address" "private_service_range" {
  name          = "google-managed-services-${var.vpc_name}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_service_range.name]
  depends_on              = [google_compute_global_address.private_service_range]
}