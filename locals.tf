locals {
  # for_each keys can't derive from a sensitive value, so build a
  # name-only key set that never touches var.users' sensitive elements.
  user_names = nonsensitive(toset([for u in var.users : u.name]))
}
