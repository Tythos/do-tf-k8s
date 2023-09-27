output "kubeconfig" {
  # to write to file: > terraform output -raw kubeconfig > .kubeconfig 
  value     = digitalocean_kubernetes_cluster.example_cluster.kube_config[0].raw_config
  sensitive = true
}
