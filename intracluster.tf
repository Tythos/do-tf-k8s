resource "kubernetes_manifest" "nginx_ingress_class" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "IngressClass"

    metadata = {
      name = "nginx"
    }

    spec = {
      controller = "k8s.io/ingress-nginx/controller"
    }
  }
}

resource "kubernetes_ingress_v1" "my_ingress" {
  metadata {
    name = "my-ingress"
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = "tythoscreatives.com"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.my_web_app_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "my_web_app_service" {
  metadata {
    name = "my-web-app-service"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "my-web-app"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_persistent_volume_claim" "my_pvc" {
  metadata {
    name = "my-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "my_web_app" {
  metadata {
    name = "my-web-app"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "my-web-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-web-app"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "web"
        }
      }
    }
  }
}
