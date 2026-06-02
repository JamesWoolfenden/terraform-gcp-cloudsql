# holden:ignore:HLD_GCP_010 — ssl_mode resolves to ENCRYPTED_ONLY when require_ssl = true (the default); holden cannot evaluate the ternary
resource "google_sql_database_instance" "this" {
  #checkov:skip=CKV_GCP_6: ssl_mode is set to ENCRYPTED_ONLY when require_ssl = true (the default); checkov cannot evaluate the ternary statically
  #checkov:skip=CKV_GCP_79: database_version is caller-controlled via var.instance.database_version; callers must specify the latest version appropriate for their workload
  database_version    = var.instance.database_version
  name                = var.name
  region              = var.instance.region
  deletion_protection = true

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]

  settings {
    tier        = var.instance.tier
    user_labels = var.labels

    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.private_network.self_link
      ssl_mode        = var.require_ssl ? "ENCRYPTED_ONLY" : "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
    }
    maintenance_window {
      day  = var.mw_day
      hour = var.mw_hour
    }
    backup_configuration {
      enabled                        = true
      start_time                     = "23:59"
      point_in_time_recovery_enabled = true
      backup_retention_settings {
        retained_backups = 7
      }
    }
    database_flags {
      name  = "log_lock_waits"
      value = "on"
    }
    database_flags {
      name  = "log_disconnections"
      value = "on"
    }
    database_flags {
      name  = "log_connections"
      value = "on"
    }
    database_flags {
      name  = "log_checkpoints"
      value = "on"
    }
  }

}
