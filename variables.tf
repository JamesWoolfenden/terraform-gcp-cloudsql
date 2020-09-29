
variable "network_name" {
  description = "The name of the VCP to provision this in to"
  type        = string
}

variable "project" {
  description = "The name of the GCP project"
  type        = string
}

variable "name" {
  description = "The name of the database instance"
  type        = string
}

variable "database" {
  description = "A list of objects that describes if any databases to be created"
  type = list(object({
    name = string
  }))
  default = []
}

variable "users" {
  description = "A list of user that belong to a database instance"
  type = list(object({
    name     = string
    password = string
  }))
  default = []
}

variable "instance" {
  type = map
  default = {
    tier             = "db-custom-1-3840"
    database_version = "POSTGRES_11"
    region           = "us-central1"
  }
}

variable "require_ssl" {
  description = "Require SSL connections or not."
  type        = bool
  default     = true
}
