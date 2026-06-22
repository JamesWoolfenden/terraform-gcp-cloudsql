resource "google_kms_crypto_key" "sql" {
  name            = "sql"
  key_ring        = "projects/my-project/locations/global/keyRings/sql-keyring"
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}
