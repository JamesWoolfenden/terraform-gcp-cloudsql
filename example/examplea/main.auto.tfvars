network_name = "vpc-network"
project      = "examplea"
name         = "name"
tier         = "db-f1-micro"
database = [{
  name = "my-database"
  },
  {
    name = "your-database"
}]
users = [{
  name     = "jimbo"
  password = "totallyvisible"
}]
