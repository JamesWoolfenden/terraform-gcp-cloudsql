resource "google_sql_user" "users" {
  count    = length(var.users)
  project  = var.project
  name     = var.users[count.index]["name"]
  instance = google_sql_database_instance.instance.name
  password = var.users[count.index]["password"]
}
