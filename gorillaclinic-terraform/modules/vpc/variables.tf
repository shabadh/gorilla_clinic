variable "network_name" {
  type        = string
  description = "Name of the network"
}

variable "auto_create_subnetworks" {
  type    = bool
  default = false

}

variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "ip_cidr_range_eu" {
  type = string
}

variable "ip_cidr_range_us" {
  type = string
}


variable "region_eu" {
  type        = string
  description = "Google Project region in Europe"
}

variable "region_us" {
  type        = string
  description = "Google Project region in US"
}


variable "env_name" {
  type        = string
  description = "The environment name"
}