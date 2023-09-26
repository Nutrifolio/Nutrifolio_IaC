terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.28"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.21.0"
    }
  }

  required_version = ">= 1.4.0"
}
