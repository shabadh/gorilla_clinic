# variable "vpc_name" {
#   type        = string
#   description = "Name of the network"
# }

# variable "auto_create_subnetworks" {
#   type    = bool
#   default = false

# }

variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

# variable "ip_cidr_range_eu" {
#   type = string
# }

# variable "ip_cidr_range_us" {
#   type = string
# }


# variable "region_eu" {
#   type        = string
#   description = "Google Project region in Europe"
# }

# variable "region_us" {
#   type        = string
#   description = "Google Project region in US"
# }


variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnets with name, CIDR, and region"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}
