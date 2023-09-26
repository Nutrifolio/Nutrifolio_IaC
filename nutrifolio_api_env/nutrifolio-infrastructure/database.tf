resource "digitalocean_database_cluster" "nutrifolio-db-cluster" {
  name                 = var.db-cluster-name
  engine               = "pg"
  version              = "15"
  size                 = "db-s-1vcpu-1gb"
  region               = var.region
  node_count           = 1
  private_network_uuid = digitalocean_vpc.nutrifolio-vpc.id
}

resource "digitalocean_database_db" "nutrifolio-db" {
  cluster_id = digitalocean_database_cluster.nutrifolio-db-cluster.id
  name       = "nutrifolio"
}

resource "digitalocean_database_user" "nutrifolio-user" {
  cluster_id = digitalocean_database_cluster.nutrifolio-db-cluster.id
  name       = "nutrifolio-user"
}

resource "digitalocean_database_firewall" "nutrifolio-db-cluster-fw" {
  cluster_id = digitalocean_database_cluster.nutrifolio-db-cluster.id

  # For the PostgreSQL Provider
  rule {
    type  = "ip_addr"
    value = chomp(data.http.my-ipv4.response_body)
  }

  rule {
    type  = "ip_addr"
    value = digitalocean_vpc.nutrifolio-vpc.ip_range
  }
}
