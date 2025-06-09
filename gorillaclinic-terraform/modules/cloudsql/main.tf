# Create Cloud SQL instance for PostgreSQL
resource "google_sql_database_instance" "primary" {
  name             = "petclinic-db-ha"
  project          = var.project_id
  region           = var.region
  database_version = "MYSQL_8_0"
  settings {
    tier              = "db-custom-2-7680"
    availability_type = "REGIONAL"
    edition           = "ENTERPRISE"
    disk_size         = 100 #Gb
    disk_type         = "PD_SSD"

    backup_configuration {
      enabled                        = true
      binary_log_enabled             = true
      start_time                     = "03:00"
      point_in_time_recovery_enabled = true
    }
    database_flags {
      name  = "max_connections"
      value = "500"
    }
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
    }

  }
}

# Create read replica
resource "google_sql_database_instance" "replica" {
  name                 = "petclinic-db-read-replica"
  project              = var.project_id
  region               = "europe-west2"
  database_version     = "MYSQL_8_0"
  master_instance_name = google_sql_database_instance.primary.name

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "db-custom-2-7680"
    disk_size         = 100 # Gb
    disk_type         = "PD_SSD"
    edition           = "ENTERPRISE"
    activation_policy = "ALWAYS"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
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
  password = var.db_password
  project  = var.project_id
}
