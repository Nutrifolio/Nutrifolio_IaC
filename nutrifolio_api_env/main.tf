terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.28.0"
    }
  }
}

variable "domain_name" {}

provider "digitalocean" {}

data "digitalocean_ssh_key" "ssh_key" {
  name = "nutrifolio-api-env"
}

resource "digitalocean_droplet" "nutrifolio-api-env" {
  image      = "ubuntu-22-10-x64"
  name       = "nutrifolio-api-env"
  region     = "fra1"
  size       = "s-1vcpu-1gb-intel"
  monitoring = true
  ssh_keys   = [data.digitalocean_ssh_key.ssh_key.id]
}

resource "digitalocean_domain" "domain" {
  name = var.domain_name
}

resource "digitalocean_record" "a-record-api" {
  domain = var.domain_name
  type   = "A"
  name   = "api"
  value  = digitalocean_droplet.nutrifolio-api-env.ipv4_address
}

resource "digitalocean_record" "a-record-pgadmin" {
  domain = var.domain_name
  type   = "A"
  name   = "pgadmin"
  value  = digitalocean_droplet.nutrifolio-api-env.ipv4_address
}

resource "digitalocean_project" "nutrifolio-project" {
  name        = "Nutrifolio"
  purpose     = "Service or API"
  environment = "Production"
  resources   = [
    digitalocean_droplet.nutrifolio-api-env.urn,
    digitalocean_domain.domain.urn
  ]
}

resource "local_file" "nutrifolio-api-env-ipv4" {
  filename = "./nutrifolio-api-env-ipv4"
  content = digitalocean_droplet.nutrifolio-api-env.ipv4_address
}
