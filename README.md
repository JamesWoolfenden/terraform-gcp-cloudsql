# terraform-gcp-cloudsql

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-cloudsql/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-cloudsql)
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
  project      = var.project
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
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database.database](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [google_compute_network.private_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database"></a> [database](#input\_database) | A list of objects that describes if any databases to be created | <pre>list(object({<br>    name = string<br>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | `map(any)` | <pre>{<br>  "database_version": "POSTGRES_11",<br>  "region": "us-central1",<br>  "tier": "db-custom-1-3840"<br>}</pre> | no |
| <a name="input_mw_day"></a> [mw\_day](#input\_mw\_day) | n/a | `number` | `1` | no |
| <a name="input_mw_hour"></a> [mw\_hour](#input\_mw\_hour) | n/a | `number` | `12` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the database instance | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the VCP to provision this in to | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The name of the GCP project | `string` | n/a | yes |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Require SSL connections or not. | `bool` | `true` | no |
| <a name="input_users"></a> [users](#input\_users) | A list of user that belong to a database instance | <pre>list(object({<br>    name     = string<br>    password = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_network"></a> [network](#output\_network) | n/a |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | n/a |
| <a name="output_vpc_connection"></a> [vpc\_connection](#output\_vpc\_connection) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Information

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

Copyright © 2019-2021 James Woolfenden

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
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-gcp-cloudsql&url=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-gcp-cloudsql&url=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_email]: mailto:?subject=terraform-gcp-cloudsql&body=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
