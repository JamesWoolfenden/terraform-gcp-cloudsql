resource "google_sql_database_instance" "this" {
  database_version    = var.instance.database_version
  name                = var.name
  region              = var.instance.region
  deletion_protection = true
  encryption_key_name = var.encryption_key_name

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]

  settings {
    tier                  = var.instance.tier
    user_labels           = var.labels
    availability_type     = "REGIONAL"
    connector_enforcement = "REQUIRED"

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = data.google_compute_network.private_network.self_link
      enable_private_path_for_google_cloud_services = true
      ssl_mode                                      = "ENCRYPTED_ONLY"
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
    database_flags {
      name  = "log_duration"
      value = "on"
    }
    database_flags {
      name  = "log_hostname"
      value = "on"
    }
    database_flags {
      name  = "log_statement"
      value = "ddl"
    }
    database_flags {
      name  = "cloudsql.enable_pgaudit"
      value = "on"
    }
    password_validation_policy {
      enable_password_policy      = true
      min_length                  = 12
      complexity                  = "COMPLEXITY_DEFAULT"
      disallow_username_substring = true
    }
  }
}

resource "google_monitoring_alert_policy" "this" {
  display_name          = "${var.name}-alert-policy"
  combiner              = "OR"
  notification_channels = var.notification_channels

  conditions {
    display_name = "Cloud SQL CPU utilization"

    condition_threshold {
      filter          = "resource.type=\"cloudsql_database\" AND resource.label.database_id=\"${google_sql_database_instance.this.project}:${google_sql_database_instance.this.name}\" AND metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "60s"

      trigger {
        count = 1
      }
    }
  }
}
