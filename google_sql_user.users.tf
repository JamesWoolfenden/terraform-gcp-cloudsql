resource "google_sql_user" "this" {
  for_each = { for u in var.users : u.name => u }
  name     = each.value.name
  instance = google_sql_database_instance.this.name
  password = each.value.password
}
