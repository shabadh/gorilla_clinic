module "vpc" {
  source     = "../../modules/vpc"
  vpc_name   = var.vpc_name
  project_id = var.project_id
}

module "gke_cluster" {
  source     = "../../modules/gke"
  project_id = var.project_id
  network    = module.vpc.vpc_network_name
  subnets    = module.vpc.subnet_names
}

module "cloudsql" {
  source     = "../../modules/cloudsql"
  project_id = var.project_id
}