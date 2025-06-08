# Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Define variables
variable "project_id" {
  default = "your-project-id"
}

variable "regions" {
  default = ["us-central1", "europe-west1"]
}

variable "cluster_names" {
  default = ["gke-us", "gke-eu"]
}

# Get project details for Workload Identity
data "google_project" "current" {}

# Create VPC network
resource "google_compute_network" "vpc" {
  name                    = "petclinic-vpc"
  auto_create_subnetworks = false
}

# Create subnetworks with secondary IP ranges
resource "google_compute_subnetwork" "subnets" {
  count         = length(var.regions)
  name          = "subnet-${var.regions[count.index]}"
  ip_cidr_range = "10.${count.index}.0.0/16"
  region        = var.regions[count.index]
  network       = google_compute_network.vpc.id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "172.16.${count.index}.0/20"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "172.17.${count.index}.0/20"
  }
}

# Create GKE clusters
resource "google_container_cluster" "primary" {
  count      = length(var.regions)
  name       = var.cluster_names[count.index]
  location   = var.regions[count.index]
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnets[count.index].name

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  workload_identity_config {
    workload_pool = "${data.google_project.current.number}.svc.id.goog"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  remove_default_node_pool = true
  initial_node_count       = 1
}

# Create node pools with autoscaling
resource "google_container_node_pool" "primary_nodes" {
  count    = length(var.regions)
  name     = "node-pool-${var.cluster_names[count.index]}"
  location = var.regions[count.index]
  cluster  = google_container_cluster.primary[count.index].name

  autoscaling {
    min_node_count = 1
    max_node_count = 100
  }

  node_config {
    machine_type = "e2-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Create Cloud SQL instance for PostgreSQL
resource "google_sql_database_instance" "primary" {
  name             = "petclinic-db"
  region           = "us-central1"
  database_version = "POSTGRES_13"
  settings {
    tier = "db-custom-2-7680"
  }
}

# Create database
resource "google_sql_database" "petclinic" {
  name     = "petclinic"
  instance = google_sql_database_instance.primary.name
}

# Create application user
resource "google_sql_user" "app_user" {
  name     = "app_user"
  instance = google_sql_database_instance.primary.name
  password = "your-strong-password"
}

# Create static IP for load balancer
resource "google_compute_address" "static_ip" {
  name   = "petclinic-ingress-ip"
  region = "us-central1"
}

# Create DNS managed zone and record
resource "google_dns_managed_zone" "petclinic" {
  name        = "petclinic"
  dns_name    = "petclinic.example.com."
  description = "DNS zone for petclinic"
}

resource "google_dns_record_set" "petclinic_a" {
  name         = "petclinic.example.com."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.petclinic.name
  rrdatas      = [google_compute_address.static_ip.address]
}