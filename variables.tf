
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

variable "tier" {
  description = "The size of the Databse instance"
  type        = string
  default     = "db-f1-micro"
}

variable "database_version" {
  description = "The Database type and version"
  type        = string
  default     = "POSTGRES_9_6"
}
