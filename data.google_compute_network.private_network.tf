data "google_compute_network" "private_network" {
  provider = google-beta

  name    = var.network_name
  project = var.project
}
