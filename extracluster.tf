resource "digitalocean_project" "example_project" {
  # project resources can include: Database Clusters; Domains; Droplets; Floating IP; Kubernetes Cluster; Load Balancers; Spaces Bucket; Volume
  name = var.DO_PROJECT

  resources = [
    digitalocean_kubernetes_cluster.example_cluster.urn,
    digitalocean_domain.example_domain.urn
  ]
}

resource "digitalocean_kubernetes_cluster" "example_cluster" {
  name    = "my-k8s-cluster"
  region  = var.DO_REGION
  version = var.DO_K8SSLUG

  node_pool {
    name       = "pool-1"
    size       = "s-2vcpu-4gb"
    node_count = 5
  }
}

resource "digitalocean_container_registry" "example_registry" {
  name                   = "do-tf-k8s-registry"
  region                 = var.DO_REGION
  subscription_tier_slug = "basic"
}

resource "digitalocean_domain" "example_domain" {
  name = "tythoscreatives.com"
}

resource "digitalocean_record" "example_domain_a" {
  domain = digitalocean_domain.example_domain.name
  type   = "A"
  name   = "k8s"
  value  = kubernetes_service.my_k8s_service.status[0].load_balancer[0].ingress[0].ip
  ttl    = 3600
}
