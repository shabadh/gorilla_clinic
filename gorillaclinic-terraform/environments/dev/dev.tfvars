# environments/dev/terraform.tfvars

project_id              = "assessment-shabadh"
vpc_name                = "gc-vpc-dev"
auto_create_subnetworks = false
# ip_cidr_range_eu        = "10.0.16.0/20"
# ip_cidr_range_us        = "10.0.0.0/20"
# region_eu               = "europe-west4"
# region_us               = "us-central1"


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
