# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "cloudsql" {
  source       = "../../"
  name         = var.name
  network_name = module.network.vpc.name
  database     = var.database
  users        = var.users
  depends_on   = [module.network]
}

module "network" {
  source        = "git::https://github.com/jameswoolfenden/terraform-gcp-network.git?ref=fb279c3" #secondary_ip_range dynamic block fix
  name          = "examplec"
  ip_cidr_range = "10.128.0.0/16"
  secondary_ip_range = [{
    ip_cidr_range = "192.168.10.0/24"
  range_name = "tf-test-secondary-range-update1" }]
  region = "europe-west2"
  common_tags = {
    pike = "permissions"
  }
}
