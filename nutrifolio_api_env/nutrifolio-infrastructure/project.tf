resource "digitalocean_project" "nutrifolio-project" {
  name        = "Nutrifolio-${var.environment}"
  purpose     = "Service or API"
  environment = var.environment
  resources   = [
    digitalocean_droplet.nutrifolio-api-droplet.urn,
    digitalocean_domain.nutrifolio-domain.urn,
    digitalocean_database_cluster.nutrifolio-db-cluster.urn,
    digitalocean_spaces_bucket.nutrifolio-sb.urn,
  ]
}
