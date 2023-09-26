data "digitalocean_ssh_key" "nutrifolio-ssh-key" {
  name = var.ssh-key-name
}

data "http" "my-ipv4" {
  url = "http://ipv4.icanhazip.com"
}
