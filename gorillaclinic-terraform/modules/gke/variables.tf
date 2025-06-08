variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "regions" {
  type    = list(string)
  default = ["europe-west4", "europe-west2"]
}

variable "cluster_names" {
  type    = list(string)
  default = ["petclinic-dev-eu", "petclinic-dev-uk"]
}
