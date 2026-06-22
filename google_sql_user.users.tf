locals {
  # for_each keys can't derive from a sensitive value, so build a
  # name-only key set that never touches var.users' sensitive elements.
  user_names = nonsensitive(toset([for u in var.users : u.name]))
}

resource "google_sql_user" "this" {
  for_each = local.user_names
  name     = each.value
  instance = google_sql_database_instance.this.name
  password = { for u in var.users : u.name => u.password }[each.value]
}
