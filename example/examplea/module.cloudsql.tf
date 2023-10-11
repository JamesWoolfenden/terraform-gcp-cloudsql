module "cloudsql" {
  source       = "../../"
  name         = var.name
  network_name = module.network.vpc.name
  database     = var.database
  users        = var.users
  depends_on   = [module.network]
}

module "network" {
  source        = "git::https://github.com/jameswoolfenden/terraform-gcp-network.git?ref=d5230e8dab3a0d2110c60da242986ac85e01d8e0"
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
