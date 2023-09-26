resource "digitalocean_record" "a-record-api" {
  domain = var.domain-name
  type   = "A"
  name   = "api"
  value  = digitalocean_droplet.nutrifolio-api-droplet.ipv4_address
}

resource "digitalocean_record" "a-record-pgadmin" {
  domain = var.domain-name
  type   = "A"
  name   = "pgadmin"
  value  = digitalocean_droplet.nutrifolio-api-droplet.ipv4_address
}
