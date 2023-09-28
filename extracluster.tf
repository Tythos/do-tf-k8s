resource "digitalocean_project" "dotf_project" {
  name        = "dotf_project"
  environment = "Development"

  # The following resource types can be associated with a project:
  #     Database Clusters
  #     Domains
  #     Droplets
  #     Floating IP
  #     Kubernetes Cluster
  #     Load Balancers
  #     Spaces Bucket
  #     Volume
  resources = [
    digitalocean_kubernetes_cluster.dotf_cluster.urn
  ]
}

resource "digitalocean_kubernetes_cluster" "dotf_cluster" {
  name    = "do-k8s-cluster"
  region  = var.DO_REGION
  version = var.DO_K8SSLUG

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 5
  }
}

resource "digitalocean_container_registry" "dotf_registry" {
  # registry name constraints:
  #     Be unique across all DigitalOcean container registries.
  #     Be no more than 63 characters in length.
  #     Contain only lowercase letters, numbers, and/or hyphens.
  #     Begin with a letter.
  #     End with a letter or number.
  name                   = "dotf-registry"
  subscription_tier_slug = "basic"
  region                 = var.DO_REGION
}
