resource "local_file" "output" {
  filename = "./variables.output"
  content = <<EOF
nutrifolio-api-env-ipv4=${digitalocean_droplet.nutrifolio-api-droplet.ipv4_address}
db_host=${digitalocean_database_cluster.nutrifolio-db-cluster.private_host}
db_port=${digitalocean_database_cluster.nutrifolio-db-cluster.port}
db_name=${digitalocean_database_db.nutrifolio-db.name}
db_user=${digitalocean_database_user.nutrifolio-user.name}
db_password=${digitalocean_database_user.nutrifolio-user.password}
sb_url=https://${digitalocean_spaces_bucket.nutrifolio-sb.bucket_domain_name}
EOF
}
