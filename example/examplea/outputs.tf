output "network" {
  value       = module.cloudsql.network
  description = "The network"
}

output "instance" {
  value       = module.cloudsql.instance
  description = "The instance"
  sensitive   = true
}

output "vpc_connection" {
  value       = module.cloudsql.vpc_connection
  description = "VPC connection"
}

output "private_ip_address" {
  value       = module.cloudsql.private_ip_address
  description = "The private IP address"
}
