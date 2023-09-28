# resource "kubernetes_namespace" "ingress_ns" {
#   metadata {
#     name = "ingress-namespace"
#   }
# }

# resource "kubernetes_deployment" "nginx" {
#   metadata {
#     name = "nginx-deployment"
#     labels = {
#       app = "nginx"
#     }
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "nginx"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "nginx"
#         }
#       }

#       spec {
#         container {
#           name  = "nginx"
#           image = "nginx:latest"

#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_ingress_v1" "nginx" {
#   metadata {
#     name      = "nginx-ingress"
#     namespace = "default"
#     annotations = {
#       "kubernetes.io/ingress.class" = "nginx"
#     }
#   }

#   spec {
#     rule {
#       host = "nginx.tythoscreatives.com"

#       http {
#         path {
#           path      = "/"
#           path_type = "Prefix"

#           backend {
#             service {
#               name = "nginx-deployment"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }
