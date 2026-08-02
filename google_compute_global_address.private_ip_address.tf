resource "google_compute_global_address" "private_ip_address" {
  name          = var.name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.private_ip_prefix_length
  network       = data.google_compute_network.private_network.self_link

  lifecycle {
    prevent_destroy = true
  }
}
