variable "network_name" {
  type = string
}
variable "name" {
  type = string
}
variable "tier" {
  type    = string
  default = "db-f1-micro"
}
variable "database_version" {
  type    = string
  default = "POSTGRES_9_6"
}
variable "database" {
  description = "A list of objects that describes if any databases to be created"
  type = list(object({
    name = string
  }))
}
variable "users" {
  description = "A list of user that belong to a database instance"
  type = list(object({
    name     = string
    password = string
  }))
  default = []
}
