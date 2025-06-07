module "vpc" {
  source                  = "../../modules/vpc"
  network_name            = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  project_id              = var.project_id
  ip_cidr_range_eu        = var.ip_cidr_range_eu
  ip_cidr_range_us        = var.ip_cidr_range_us
  region_eu               = var.region_eu
  region_us               = var.region_us
}