terraform {
  backend "gcs" {
    bucket = "gorillaclinic-dev-tf-state"
    prefix = "environments/dev/terraform.tfstate"
  }
}