resource "google_kms_crypto_key" "sql" {
  name            = "sql"
  key_ring        = "projects/my-project/locations/global/keyRings/sql-keyring"
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}

data "google_project" "this" {}

resource "google_kms_crypto_key_iam_member" "cloudsql_sa" {
  crypto_key_id = google_kms_crypto_key.sql.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.this.number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"
}
