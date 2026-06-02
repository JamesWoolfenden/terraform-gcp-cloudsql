resource "google_sql_database" "this" {
  for_each = { for db in var.database : db.name => db }
  name     = each.value.name
  instance = google_sql_database_instance.this.name
}
