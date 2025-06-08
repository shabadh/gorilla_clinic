# Create Cloud SQL instance for PostgreSQL
resource "google_sql_database_instance" "primary" {
  name             = "petclinic-db-ha"
  project          = var.project_id
  region           = "europe-west4"
  database_version = "MYSQL_8_0"
  settings {
    tier              = "db-custom-2-7680"
    availability_type = "REGIONAL"
    edition           = "ENTERPRISE"
    disk_size         = 100 #Gb
    disk_type         = "PD_SSD"

    backup_configuration {
      enabled = true
      binary_log_enabled = true
    }
  }
}

# Create database
resource "google_sql_database" "petclinic" {
  name     = "petclinic"
  instance = google_sql_database_instance.primary.name
  project  = var.project_id
}

# Create application user
resource "google_sql_user" "app_user" {
  name     = "petclinic"
  instance = google_sql_database_instance.primary.name
  password = "petclinic"
  project  = var.project_id
}
