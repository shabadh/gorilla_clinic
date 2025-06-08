variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "regions" {
  type    = list(string)
  default = ["europe-west4", "europe-west2"]
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
