resource "digitalocean_vpc" "nutrifolio-vpc" {
  name     = var.vpc-name
  region   = var.region
}
