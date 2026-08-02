resource "google_monitoring_notification_channel" "email" {
  display_name = "cloudsql-alerts"
  type         = "email"
  labels = {
    email_address = "oncall@example.com"
  }
}

# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "cloudsql" {
  source                = "../../"
  name                  = var.name
  network_name          = module.network.vpc.name
  database              = var.database
  users                 = var.users
  encryption_key_name   = google_kms_crypto_key.sql.id
  notification_channels = [google_monitoring_notification_channel.email.name]
  depends_on            = [module.network]
}

module "network" {
  source        = "git::https://github.com/jameswoolfenden/terraform-gcp-network.git?ref=048f2f7ee279518dc87aa862b6f2bb973fa00b85"
  name          = "examplec"
  ip_cidr_range = "10.128.0.0/16"
  secondary_ip_range = [{
    ip_cidr_range = "192.168.10.0/24"
    range_name    = "tf-test-secondary-range-update1"
  }]
  region = "europe-west2"
}
