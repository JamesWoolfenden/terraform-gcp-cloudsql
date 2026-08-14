
resource "google_sql_user" "this" {
  for_each = local.user_names
  name     = each.value
  instance = google_sql_database_instance.this.name
  password = { for u in var.users : u.name => u.password }[each.value]
}
