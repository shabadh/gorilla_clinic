# Firewall rule for Gateway
resource "google_compute_firewall" "allow_gateway" {
  name    = "allow-gateway-health-checks"
  network = data.google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"] # Health check ranges
  target_tags   = ["gke-nodes"]
}