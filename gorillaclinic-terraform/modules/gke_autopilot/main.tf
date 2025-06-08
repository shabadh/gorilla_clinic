# resource "google_container_cluster" "autopilot" {
#   name       = var.cluster_name
#   project    = var.project_id
#   location   = var.region
#   network    = var.vpc_id
#   subnetwork = var.subnet_id

#   enable_autopilot = true

#   release_channel {
#     channel = "REGULAR"
#   }

#   ip_allocation_policy {
#     cluster_secondary_range_name  = var.pod_range
#     services_secondary_range_name = var.service_range
#   }

#   workload_identity_config {
#     workload_pool = "${var.project_id}.svc.id.goog"
#   }

#   binary_authorization {
#     evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
#   }

#   vertical_pod_autoscaling {
#     enabled = true
#   }
# }
