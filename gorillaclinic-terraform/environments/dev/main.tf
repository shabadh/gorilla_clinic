# module "vpc" {
#   source                  = "../../modules/vpc"
#   network_name            = var.network_name
#   auto_create_subnetworks = var.auto_create_subnetworks
#   project_id              = var.project_id
#   ip_cidr_range_eu        = var.ip_cidr_range_eu
#   ip_cidr_range_us        = var.ip_cidr_range_us
#   region_eu               = var.region_eu
#   region_us               = var.region_us
# }

module "vpc" {
  source     = "../../modules/vpc"
  vpc_name   = var.vpc_name
  project_id = var.project_id
  subnets    = var.subnets
  regions    = var.region
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
