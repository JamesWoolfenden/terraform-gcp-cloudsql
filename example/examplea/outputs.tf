output "network" {
  value = module.cloudsql.network
}

output "instance" {
  value = module.cloudsql.instance
}

output "vpc_connection" {
  value = module.cloudsql.vpc_connection
}

output "private_ip_address" {
  value = module.cloudsql.private_ip_address
}
