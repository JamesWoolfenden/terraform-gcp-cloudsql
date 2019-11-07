resource "google_compute_global_address" "private_ip_address" {
  provider      = "google-beta"

  name          = var.name
  purpose       = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network       = data.google_compute_network.private_network.self_link
}