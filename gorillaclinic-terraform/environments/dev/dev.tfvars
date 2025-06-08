# environments/dev/terraform.tfvars

project_id              = "assessment-shabadh"
vpc_name                = "gc-vpc-dev"
auto_create_subnetworks = false
subnets = [
  {
    name   = "gc-uk-subnet1-dev"
    cidr   = "10.10.0.0/20"
    region = "europe-west2"
  },
  {
    name   = "gc-nl-subnet1-dev"
    cidr   = "10.20.0.0/20"
    region = "europe-west4"
  }
]

cluster_name  = "gc-autopilot-dev"
region        = "europe-west4"
pod_range     = "pods-range-dev"
service_range = "services-range-dev"