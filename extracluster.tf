resource "digitalocean_kubernetes_cluster" "default" {
  name    = "do-k8s-cluster"
  region  = var.DO_REGION
  version = var.DO_K8SSLUG

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 5
  }
}
