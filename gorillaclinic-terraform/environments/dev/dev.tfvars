# environments/dev/terraform.tfvars

project_id              = "assessment-shabadh"
vpc_name                = "gc-vpc-dev"
auto_create_subnetworks = false
regions = [
  europe-west4, # Netherlands
  europe-west2  # UK
]
subnets = [
  {
    name   = "gc-uk-dev"
    cidr   = "10.0.0.0/16"
    region = "europe-west2"
  },
  {
    name   = "gc-nl-dev"
    cidr   = "10.1.0.0/16"
    region = "europe-west4"
  }
]
