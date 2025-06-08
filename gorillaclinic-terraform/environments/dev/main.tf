module "vpc" {
  source     = "../../modules/vpc"
  vpc_name   = var.vpc_name
  project_id = var.project_id

}

# module "gke_autopilot" {
#   source        = "../../modules/gke_autopilot"
#   project_id    = var.project_id
#   cluster_name  = var.cluster_name
#   region        = var.region
#   vpc_id        = module.vpc.vpc_id
#   subnet_id     = module.vpc.subnet_ids["gc-nl-subnet1-dev"]
#   pod_range     = var.pod_range
#   service_range = var.service_range
# }
