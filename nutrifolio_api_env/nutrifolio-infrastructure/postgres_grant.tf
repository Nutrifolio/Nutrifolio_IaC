resource "postgresql_grant" "nutrifolio-table-privileges" {
  database    = digitalocean_database_db.nutrifolio-db.name
  role        = digitalocean_database_user.nutrifolio-user.name
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE"]
}

resource "postgresql_grant" "nutrifolio-db-privileges" {
  database    = digitalocean_database_db.nutrifolio-db.name
  role        = digitalocean_database_user.nutrifolio-user.name
  schema      = "public"
  object_type = "schema"
  privileges  = ["CREATE"]
}
