
# output "vpc_id" {
#   value = google_compute_network.vpc.id
# }

# output "subnet_eu_id" {
#   value = google_compute_subnetwork.subnet_eu.id
# }

# output "subnet_us_id" {
#   value = google_compute_subnetwork.subnet_us.id
# }


output "vpc_id" {
  description = "The ID of the created VPC"
  value       = google_compute_network.vpc.id
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for s in google_compute_subnetwork.subnets : s.name => s.id }
}
