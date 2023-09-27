resource "kubernetes_service" "my_k8s_service" {
  metadata {
    name = "my-k8s-service"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "my-app"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name = "nginx-deployment"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "nginx_ingress_controller" {
  metadata {
    name = "nginx-ingress-controller"
    labels = {
      app = "ingress-nginx"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ingress-nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "ingress-nginx"
        }
      }
      spec {
        container {
          name  = "nginx-ingress-controller"
          image = "quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.27.1" # Replace with the desired NGINX Ingress Controller image version
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx_ingress_controller" {
  metadata {
    name = "nginx-ingress-controller"
    labels = {
      app = "ingress-nginx"
    }
  }

  spec {
    selector = {
      app = "ingress-nginx"
    }
    ports {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer" # Use "LoadBalancer" type if you want to expose the Ingress controller externally
  }
}

resource "kubernetes_config_map" "nginx_ingress_config" {
  metadata {
    name = "nginx-config"
  }

  data = {
    # Add your NGINX Ingress configuration here (e.g., custom error pages, proxy-buffer-size, etc.)
  }
}
