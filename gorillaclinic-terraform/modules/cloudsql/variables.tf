variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "petclinic" # Only for test/demo purpose
}

variable "vpc_self_link" {
  description = "VPC self link for private IP connectivity"
  type        = string
}

variable "region" {
  type    = string
  default = "europe-west4"
}