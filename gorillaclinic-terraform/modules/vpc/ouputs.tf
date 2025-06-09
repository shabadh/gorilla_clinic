output "vpc_id" {
  description = "The ID of the created VPC"
  value       = google_compute_network.vpc.id
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for s in google_compute_subnetwork.subnets : s.name => s.id }
}

output "subnet_names" {
  description = "List of subnet names created"
  value       = google_compute_subnetwork.subnets[*].name
}

output "vpc_network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "vpc_network_id" {
  value = google_compute_network.vpc.id
}