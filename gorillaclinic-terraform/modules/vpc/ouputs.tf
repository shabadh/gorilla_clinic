
output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "subnet_eu_id" {
  value = google_compute_subnetwork.subnet_eu.id
}

output "subnet_us_id" {
  value = google_compute_subnetwork.subnet_us.id
}
