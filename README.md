# terraform-gcp-cloudsql

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-cloudsql/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-cloudsql)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-cloudsql.svg)](https://github.com/JamesWoolfenden/terraform-gcp-cloudsql/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

The beginnings of a cloudsql module for GCP, currently targeting a private endpoint.

## Usage

You need to have enabled the API's for this to work if you haven't used this part of GCP before:

[servicenetworking.googleapis.com](https://console.developers.google.com/apis/api/servicenetworking.googleapis.com/overview)

[sqladmin.googleapis.com](https://console.developers.google.com/apis/api/sqladmin.googleapis.com/overview)

Add **module.cloudsql.tf** to your code:-

```terraform
module cloudsql {
  source       = "JamesWoolfenden/cloudsql/gcp"
  version      = "0.1.13"
  name         = var.name
  network_name = var.network_name
  database     = var.database
  users        = var.users
}
```

You can also create databases with this module and the variable database:

```terraform
variable "database" {
    type=list(object({
        name = string
    }))
    default=[]
}
```

Setting database to

```terraform
    database=[{
        name= "my-database"
    },
    {
        name= "your-database"
    }]
```

Will create 2 databases.

You can then optionally create resource based on that object being populated, or not.

```terraform
resource "google_sql_database" "database" {
  count    = length(var.database)
  name     = var.database[count.index]["name"]
  instance = google_sql_database_instance.instance.name
}
```

The "Users" variable and resource follows the same pattern.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [google_compute_network.private_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_database"></a> [database](#input\_database) | Databases to create on the instance. | <pre>list(object({<br/>    name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | Cloud SQL instance configuration. | <pre>object({<br/>    tier             = optional(string, "db-custom-1-3840")<br/>    database_version = optional(string, "POSTGRES_16")<br/>    region           = optional(string, "us-central1")<br/>  })</pre> | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to all resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_mw_day"></a> [mw\_day](#input\_mw\_day) | Day of the week for the maintenance window (1 = Monday, 7 = Sunday). | `number` | `1` | no |
| <a name="input_mw_hour"></a> [mw\_hour](#input\_mw\_hour) | Hour of the day (UTC) for the maintenance window (0â€“23). | `number` | `12` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cloud SQL instance. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the VPC network to provision this instance into. | `string` | n/a | yes |
| <a name="input_private_ip_prefix_length"></a> [private\_ip\_prefix\_length](#input\_private\_ip\_prefix\_length) | Prefix length for the private IP range reserved for VPC peering (e.g. 24 = 256 addresses, sufficient for Cloud SQL). | `number` | `24` | no |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Require SSL for all incoming connections (sets ssl\_mode to ENCRYPTED\_ONLY). | `bool` | `true` | no |
| <a name="input_users"></a> [users](#input\_users) | Users to create on the instance. Passwords are stored in Terraform state â€” prefer random\_password references rather than literal values. | <pre>list(object({<br/>    name     = string<br/>    password = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_instance"></a> [instance](#output\_instance) | The Cloud SQL database instance (sensitive â€” contains connection details). |
| <a name="output_network"></a> [network](#output\_network) | The private VPC network data source used by the Cloud SQL instance. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The reserved global internal IP address for the VPC peering range. |
| <a name="output_vpc_connection"></a> [vpc\_connection](#output\_vpc\_connection) | The private VPC peering connection for the Cloud SQL private services access. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang

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


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-codecommit](https://github.com/jameswoolfenden/terraform-aws-codebuild) - Storing ones code

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-gcp-cloudsql/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-gcp-cloudsql/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2026 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
