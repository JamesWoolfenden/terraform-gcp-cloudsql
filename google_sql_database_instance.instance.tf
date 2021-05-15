resource "google_sql_database_instance" "instance" {
  #checkov:skip=CKV_GCP_6: "Ensure all Cloud SQL database instance requires all incoming connections to use SSL"
  database_version = var.instance["database_version"]
  name             = var.name
  region           = var.instance["region"]
  project          = var.project

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]

  settings {
    tier = var.instance["tier"]
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.private_network.self_link
      require_ssl     = var.require_ssl
    }
    maintenance_window {
      day  = null
      hour = null
    }
    backup_configuration {
      enabled    = true
      start_time = "23:59"
    }
  }

}
