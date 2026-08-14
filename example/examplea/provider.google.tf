# holden:ignore:HLD_GCP_059 — per-repo WIF SA with attribute.repository scoping
# provides equivalent least-privilege without impersonation.
provider "google" {
  project = "pike-477416"
  default_labels = {
    created_by = "terraform"
    module     = "terraform-gcp-cloudsql"
  }
}
