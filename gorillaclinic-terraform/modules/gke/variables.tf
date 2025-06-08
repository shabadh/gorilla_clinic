variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
  default     = "assessment-shabadh"
}

variable "regions" {
  type    = list(string)
  default = ["europe-west4", "europe-west2"]
}

variable "cluster_names" {
  type    = list(string)
  default = ["petclinic-dev-eu", "petclinic-dev-uk"]
}

variable "network" {
  type        = string
  description = "VPC network name"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet names"
}