# # Create Cloud SQL instance for PostgreSQL
# resource "google_sql_database_instance" "primary" {
#   name             = "petclinic-db"
#   project          = var.project_id
#   region           = "europe-west4"
#   database_version = "POSTGRES_17"
#   settings {
#     tier = "db-custom-2-7680"
#   }
# }

# # Create database
# resource "google_sql_database" "petclinic" {
#   name     = "petclinic"
#   instance = google_sql_database_instance.primary.name
# }

# # Create application user
# resource "google_sql_user" "app_user" {
#   name     = "app_user"
#   instance = google_sql_database_instance.primary.name
#   password = "strong-password"
# }