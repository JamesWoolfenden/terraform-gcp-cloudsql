output "network" {
  value = data.google_compute_network.private_network
}

output "instance" {
  sensitive = true
  value     = google_sql_database_instance.instance
}

output "vpc_connection" {
  value = google_service_networking_connection.private_vpc_connection
}

output "private_ip_address" {
  value = google_compute_global_address.private_ip_address
}
