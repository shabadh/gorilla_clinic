variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "regions" {
  type = list(string)
}

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
