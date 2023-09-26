resource "digitalocean_droplet" "nutrifolio-api-droplet" {
  image      = "ubuntu-22-04-x64"
  name       = "nutrifolio-api-droplet"
  region     = var.region
  size       = "s-1vcpu-1gb"
  monitoring = true
  ssh_keys   = [data.digitalocean_ssh_key.nutrifolio-ssh-key.id]
  vpc_uuid   = digitalocean_vpc.nutrifolio-vpc.id
}
