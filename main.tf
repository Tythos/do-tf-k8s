resource "digitalocean_container_registry" "docr" {
  name                   = "${var.DO_PROJECT}-docr"
  subscription_tier_slug = "starter"
  region                 = var.DO_REGION
}

resource "digitalocean_project" "dop" {
  name        = var.DO_PROJECT
  environment = "Development"

  # project resource can include: db clusters; domains; droplets; floating IPs; k8s clusters; LBs; space buckets; and volumes
  resources = [
    digitalocean_kubernetes_cluster.k8s.urn
  ]
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name                             = "k8s"
  region                           = var.DO_REGION
  version                          = var.DO_K8SSLUG
  destroy_all_associated_resources = true

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}
