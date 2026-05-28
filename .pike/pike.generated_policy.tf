
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "cloudsql.databases.create",
    "cloudsql.databases.delete",
    "cloudsql.databases.get",
    "cloudsql.databases.update",
    "cloudsql.instances.create",
    "cloudsql.instances.delete",
    "cloudsql.instances.get",
    "cloudsql.instances.update",
    "cloudsql.users.create",
    "cloudsql.users.delete",
    "cloudsql.users.list",
    "cloudsql.users.update",
    "compute.globalAddresses.create",
    "compute.globalAddresses.createInternal",
    "compute.globalAddresses.delete",
    "compute.globalAddresses.deleteInternal",
    "compute.globalAddresses.get",
    "compute.globalAddresses.setLabels",
    "compute.networks.get",
    "compute.networks.removePeering",
    "compute.networks.use",
    "resourcemanager.projects.get",
    "servicenetworking.services.addPeering",
    "servicenetworking.services.deleteConnection",
    "servicenetworking.services.get",
    "serviceusage.operations.get"
  ]
}
