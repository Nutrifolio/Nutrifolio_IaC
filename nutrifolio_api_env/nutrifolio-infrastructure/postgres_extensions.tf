resource "postgresql_extension" "postgis" {
  name     = "postgis"
  database = digitalocean_database_db.nutrifolio-db.name
}
