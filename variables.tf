
variable "network_name" {
  description = "The name of the VPC network to provision this instance into."
  type        = string
  validation {
    condition     = length(var.network_name) > 0
    error_message = "network_name must not be empty."
  }
}

variable "name" {
  description = "The name of the Cloud SQL instance."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "name must not be empty."
  }
}

variable "database" {
  description = "Databases to create on the instance."
  type = list(object({
    name = string
  }))
  default = []
  validation {
    condition     = alltrue([for db in var.database : length(db.name) > 0])
    error_message = "All database names must not be empty."
  }
}

variable "users" {
  description = "Users to create on the instance. Passwords are stored in Terraform state — prefer random_password references rather than literal values."
  type = list(object({
    name     = string
    password = string
  }))
  default   = []
  sensitive = true
  validation {
    condition     = alltrue([for u in var.users : length(u.name) > 0])
    error_message = "All user names must not be empty."
  }
}

variable "instance" {
  description = "Cloud SQL instance configuration."
  type = object({
    tier             = optional(string, "db-custom-1-3840")
    database_version = optional(string, "POSTGRES_16")
    region           = optional(string, "us-central1")
  })
  default = {}
  validation {
    condition     = length(var.instance.tier) > 0 && length(var.instance.region) > 0
    error_message = "instance.tier and instance.region must not be empty."
  }
}

variable "encryption_key_name" {
  description = "Fully-qualified KMS key ID used to encrypt the Cloud SQL instance's disk."
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.encryption_key_name) > 0
    error_message = "encryption_key_name must be a non-empty KMS key ID."
  }
}

variable "labels" {
  description = "Labels to apply to all resources created by this module."
  type        = map(string)
  default     = {}
  validation {
    condition     = alltrue([for k in keys(var.labels) : can(regex("^[a-z0-9_-]+$", k))])
    error_message = "All label keys must match ^[a-z0-9_-]+$."
  }
}

variable "mw_day" {
  description = "Day of the week for the maintenance window (1 = Monday, 7 = Sunday)."
  type        = number
  default     = 7
  validation {
    condition     = var.mw_day >= 1 && var.mw_day <= 7
    error_message = "mw_day must be between 1 (Monday) and 7 (Sunday)."
  }
}

variable "mw_hour" {
  description = "Hour of the day (UTC) for the maintenance window (0–23)."
  type        = number
  default     = 6
  validation {
    condition     = var.mw_hour >= 0 && var.mw_hour <= 23
    error_message = "mw_hour must be between 0 and 23."
  }
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

variable "notification_channels" {
  description = "Monitoring notification channel IDs to alert when the Cloud SQL instance's CPU utilization is critical."
  type        = list(string)
  validation {
    condition     = length(var.notification_channels) > 0 && alltrue([for c in var.notification_channels : length(c) > 0])
    error_message = "notification_channels must contain at least one non-empty channel ID."
  }
}
