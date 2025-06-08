output "location" {
  value = google_container_cluster.primary[*].location
}

output "endpoint" {
  value = google_container_cluster.primary[*].endpoint
}

output "cluster_name" {
  value = google_container_cluster.primary[*].name
}