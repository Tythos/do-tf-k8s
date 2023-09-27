output "kubeconfig" {
  # to write to file: > terraform output -raw kubeconfig > .kubeconfig 
  value     = digitalocean_kubernetes_cluster.default.kube_config[0].raw_config
  sensitive = true
}

output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.default.endpoint
}
