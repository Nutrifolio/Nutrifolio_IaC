provider "postgresql" {
  host      = digitalocean_database_cluster.nutrifolio-db-cluster.host
  port      = digitalocean_database_cluster.nutrifolio-db-cluster.port
  database  = digitalocean_database_db.nutrifolio-db.name
  username  = digitalocean_database_cluster.nutrifolio-db-cluster.user
  password  = digitalocean_database_cluster.nutrifolio-db-cluster.password
  sslmode   = "require"
}
