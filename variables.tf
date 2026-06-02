
variable "network_name" {
  description = "The name of the VCP to provision this in to"
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
  description = "A list of users to create on the database instance. Passwords are stored in Terraform state — prefer passing random_password references rather than literal values."
  type = list(object({
    name     = string
    password = string
  }))
  default   = []
  sensitive = true
}

variable "instance" {
  type = map(any)
  default = {
    tier             = "db-custom-1-3840"
    database_version = "POSTGRES_14"
    region           = "us-central1"
  }
}

variable "require_ssl" {
  description = "Require SSL connections or not."
  type        = bool
  default     = true
}

variable "labels" {
  description = "Labels to apply to all resources created by this module."
  type        = map(string)
  default     = {}
}

variable "private_ip_prefix_length" {
  description = "Prefix length for the private IP range reserved for VPC peering (e.g. 24 = 256 addresses, sufficient for Cloud SQL)."
  type        = number
  default     = 24
  validation {
    condition     = var.private_ip_prefix_length >= 16 && var.private_ip_prefix_length <= 29
    error_message = "private_ip_prefix_length must be between 16 and 29."
  }
}
