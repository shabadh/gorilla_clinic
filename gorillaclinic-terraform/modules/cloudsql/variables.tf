variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "petclinic" # Only for test/demo purpose
}

variable "region" {
  type    = string
  default = "europe-west4"
}