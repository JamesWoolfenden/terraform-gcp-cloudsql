[![Slalom][logo]](https://slalom.com)

# terraform-gcp-cloudsql [![Build Status](https://api.travis-ci.com/JamesWoolfenden/terraform-gcp-cloudsql.svg?branch=master)](https://travis-ci.com/JamesWoolfenden/terraform-gcp-cloudsql) [![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-cloudsql.svg)](https://github.com/JamesWoolfenden/terraform-gcp-cloudsql/releases/latest)

The beginnings of a cloudsql module for GCP, currently targeting a private endpoint.

## Usage

You might/will have to enabe the API's for this to work if you havent used this part of GCP before:

[servicenetworking.googleapis.com](https://console.developers.google.com/apis/api/servicenetworking.googleapis.com/overview)

[sqladmin.googleapis.com](https://console.developers.google.com/apis/api/sqladmin.googleapis.com/overview)

Add **module.cloudsql.tf** to your code:-

```terraform
module "cloudsql" {
  source       = "JamesWoolfenden/cloudsql/gcp"
  version      = "0.1.13"
  name         = var.name
  project      = var.project
  network_name = var.network_name
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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| database | A list of objects that describes if any databases to be created | object | `[]` | no |
| database\_version | The Database type and version | string | `"POSTGRES_9_6"` | no |
| name | The name of the database instance | string | n/a | yes |
| network\_name | The name of the VCP to provision this in to | string | n/a | yes |
| project | The name of the GCP project | string | n/a | yes |
| tier | The size of the Databse instance | string | `"db-f1-micro"` | no |
| users | A list of user that belong to a database instance | object | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance |  |
| network | Required for to publish Modules |
| private\_ip\_address |  |
| vpc\_connection |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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

Copyright © 2019-2019 [Slalom, LLC](https://slalom.com)

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
[logo]: https://gist.githubusercontent.com/JamesWoolfenden/5c457434351e9fe732ca22b78fdd7d5e/raw/15933294ae2b00f5dba6557d2be88f4b4da21201/slalom-logo.png
[website]: https://slalom.com
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/company/slalom-consulting/
[twitter]: https://twitter.com/Slalom
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-gcp-cloudsql&url=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-gcp-cloudsql&url=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
[share_email]: mailto:?subject=terraform-gcp-cloudsql&body=https://github.com/jameswoolfenden/terraform-gcp-cloudsql
