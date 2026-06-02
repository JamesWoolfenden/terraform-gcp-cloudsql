output "network" {
  description = "The private VPC network data source used by the Cloud SQL instance."
  value       = data.google_compute_network.private_network
}

output "instance" {
  description = "The Cloud SQL database instance (sensitive — contains connection details)."
  sensitive   = true
  value       = google_sql_database_instance.this
}

output "vpc_connection" {
  description = "The private VPC peering connection for the Cloud SQL private services access."
  value       = google_service_networking_connection.private_vpc_connection
}

output "private_ip_address" {
  description = "The reserved global internal IP address for the VPC peering range."
  value       = google_compute_global_address.private_ip_address
}
