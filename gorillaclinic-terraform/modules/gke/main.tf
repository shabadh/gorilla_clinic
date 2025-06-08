# data "google_project" "live" {
#   project_id = var.project_id
# }

# Create GKE clusters
resource "google_container_cluster" "primary" {
  count      = length(var.regions)
  name       = var.cluster_names[count.index]
  location   = var.regions[count.index]
  network    = var.network
  subnetwork = var.subnets[count.index]
  project    = var.project_id

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  vertical_pod_autoscaling {
    enabled = true
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
  project  = var.project_id

  autoscaling {
    min_node_count = 1
    max_node_count = 6
  }

  node_config {
    machine_type = "e2-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_compute_address" "static_ip" {
  name   = "petclinic-ingress-ip"
  region = "europe-west4"
}