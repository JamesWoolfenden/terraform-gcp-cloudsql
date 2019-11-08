module cloudsql {
  source       = "../../"
  name         = var.name
  project      = var.project
  network_name = var.network_name
  database     = var.database
  users        = var.users
}
