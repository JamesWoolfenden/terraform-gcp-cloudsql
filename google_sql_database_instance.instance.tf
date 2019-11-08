resource "google_sql_database_instance" "instance" {
  provider         = "google-beta"
  database_version = var.database_version
  name             = var.name
  region           = "us-central1"

  project = var.project

  depends_on = [
    "google_service_networking_connection.private_vpc_connection"
  ]

  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.private_network.self_link
    }
  }
}
