variable "name" {
  description = "The name of the Cloud SQL instance"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "name must not be empty."
  }
}
# variable "tier" {
#   description = "The machine type for the Cloud SQL instance"
#   type        = string
#   default     = "db-f1-micro"

#   validation {
#     condition     = length(var.tier) > 0
#     error_message = "tier must not be empty."
#   }
# }
variable "database" {
  description = "A list of objects that describes if any databases to be created"
  type = list(object({
    name = string
  }))

  validation {
    condition     = alltrue([for db in var.database : length(db.name) > 0])
    error_message = "each database object must have a non-empty name."
  }
}
variable "users" {
  description = "A list of users that belong to a database instance"
  type = list(object({
    name     = string
    password = string
  }))
  default = []

  validation {
    condition     = alltrue([for user in var.users : length(user.name) > 0 && length(user.password) > 0])
    error_message = "each user object must have a non-empty name and password."
  }
}

# # reference variables that might otherwise be unused in this example to satisfy linters
# locals {
#   _example_references = {
#     tier     = var.tier
#     name     = var.name
#     database = var.database
#     users    = var.users
#   }
# }
