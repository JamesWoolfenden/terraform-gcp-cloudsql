data "google_compute_network" "private_network" {
  name    = var.network_name
  project = var.project
}
