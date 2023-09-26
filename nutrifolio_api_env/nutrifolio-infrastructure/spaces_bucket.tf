resource "digitalocean_spaces_bucket" "nutrifolio-sb" {
  name   = var.sb-name
  region = var.region
}
